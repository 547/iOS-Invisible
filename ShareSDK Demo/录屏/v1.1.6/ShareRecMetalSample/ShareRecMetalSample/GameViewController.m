

#import "GameViewController.h"

@import Metal;
@import simd;
@import QuartzCore.CAMetalLayer;

#import <ShareREC/ShareREC.h>
#import <ShareRECSocial/ShareRECSocial.h>
#import <ShareREC/Extention/ShareREC+Ext.h>
#import <AVFoundation/AVFoundation.h>
#import <ShareREC/Extention/ShareREC+RecordingManager.h>
#import <ShareREC/Extention/SRERecording.h>

#define BUTTON_HEIGHT 50

typedef enum {
    RECORD_INVALID = 0,
    RECORD_START = 1,
    RECORD_STOP  = 2,
    RECORD_PUASE = 3,
    RECORD_RESUME = 4,
} RecordState;

// The max number of command buffers in flight
static const NSUInteger g_max_inflight_buffers = 3;

// Max API memory buffer size.
static const size_t MAX_BYTES_PER_FRAME = 1024*1024;

float cubeVertexData[216] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5, -0.5, 0.5,   0.0, -1.0,  0.0,
    -0.5, -0.5, 0.5,   0.0, -1.0, 0.0,
    -0.5, -0.5, -0.5,   0.0, -1.0,  0.0,
    0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
    0.5, -0.5, 0.5,   0.0, -1.0,  0.0,
    -0.5, -0.5, -0.5,   0.0, -1.0,  0.0,
    
    0.5, 0.5, 0.5,    1.0, 0.0,  0.0,
    0.5, -0.5, 0.5,   1.0,  0.0,  0.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
    0.5, 0.5, -0.5,   1.0, 0.0,  0.0,
    0.5, 0.5, 0.5,    1.0, 0.0,  0.0,
    0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
    
    -0.5, 0.5, 0.5,    0.0, 1.0,  0.0,
    0.5, 0.5, 0.5,    0.0, 1.0,  0.0,
    0.5, 0.5, -0.5,   0.0, 1.0,  0.0,
    -0.5, 0.5, -0.5,   0.0, 1.0,  0.0,
    -0.5, 0.5, 0.5,    0.0, 1.0,  0.0,
    0.5, 0.5, -0.5,   0.0, 1.0,  0.0,
    
    -0.5, -0.5, 0.5,  -1.0,  0.0, 0.0,
    -0.5, 0.5, 0.5,   -1.0, 0.0,  0.0,
    -0.5, 0.5, -0.5,  -1.0, 0.0,  0.0,
    -0.5, -0.5, -0.5,  -1.0,  0.0,  0.0,
    -0.5, -0.5, 0.5,  -1.0,  0.0, 0.0,
    -0.5, 0.5, -0.5,  -1.0, 0.0,  0.0,
    
    0.5, 0.5,  0.5,  0.0, 0.0,  1.0,
    -0.5, 0.5,  0.5,  0.0, 0.0,  1.0,
    -0.5, -0.5, 0.5,   0.0,  0.0, 1.0,
    -0.5, -0.5, 0.5,   0.0,  0.0, 1.0,
    0.5, -0.5, 0.5,   0.0,  0.0,  1.0,
    0.5, 0.5,  0.5,  0.0, 0.0,  1.0,
    
    0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
    -0.5, -0.5, -0.5,   0.0,  0.0, -1.0,
    -0.5, 0.5, -0.5,  0.0, 0.0, -1.0,
    0.5, 0.5, -0.5,  0.0, 0.0, -1.0,
    0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
    -0.5, 0.5, -0.5,  0.0, 0.0, -1.0
};

typedef struct
{
    matrix_float4x4 modelview_projection_matrix;
    matrix_float4x4 normal_matrix;
} uniforms_t;

@interface GameViewController()
{
    // layer
    CAMetalLayer *_metalLayer;
    BOOL _layerSizeDidUpdate;
    MTLRenderPassDescriptor *_renderPassDescriptor;
    
    // controller
    CADisplayLink *_timer;
    BOOL _gameLoopPaused;
    dispatch_semaphore_t _inflight_semaphore;
    id <MTLBuffer> _dynamicConstantBuffer;
    uint8_t _constantDataBufferIndex;
    
    // renderer
    id <MTLDevice> _device;
    id <MTLCommandQueue> _commandQueue;
    id <MTLLibrary> _defaultLibrary;
    id <MTLRenderPipelineState> _pipelineState;
    id <MTLBuffer> _vertexBuffer;
    id <MTLDepthStencilState> _depthState;
    id <MTLTexture> _depthTex;
    id <MTLTexture> _msaaTex;
    
    // uniforms
    matrix_float4x4 _projectionMatrix;
    matrix_float4x4 _viewMatrix;
    uniforms_t _uniform_buffer;
    float _rotation;
    
    UIButton * _recordButton;
    UIButton * _stateButton;
    UIButton * _shareButton;
    UIButton * _editButton;
    UIButton * _playButton;
    UIButton * _getRecListButton;//获取本地视频列表
    UIButton * _deleteRecListButton; //删除本地视频列表
    
    CFAbsoluteTime                      _startTime;
    NSTimer *_labelTimer;
    
    RecordState currentState;
    
    AVAudioPlayer *_player;
}

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation GameViewController


- (void)dealloc
{
    [_timer invalidate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CA" withExtension:@"mp3"] error:NULL];
    [_player prepareToPlay];
    [_player play];
    
    _constantDataBufferIndex = 0;
    _inflight_semaphore = dispatch_semaphore_create(g_max_inflight_buffers);
    
    [self _setupMetal];
    [self _loadAssets];
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_gameloop)];
    [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_recordButton setTitle:@"开始录制" forState:UIControlStateNormal];
    [_recordButton setTitle:@"结束录制" forState:UIControlStateSelected];
    [_recordButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_recordButton addTarget:self action:@selector(recordButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_recordButton setBackgroundColor:[UIColor yellowColor]];
    _recordButton.frame = CGRectMake(10, 20, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_recordButton];
    
    _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_stateButton setTitle:@"暂停录制" forState:UIControlStateNormal];
    [_stateButton setTitle:@"恢复录制" forState:UIControlStateSelected];
    [_stateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stateButton addTarget:self action:@selector(stateButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_stateButton setBackgroundColor:[UIColor redColor]];
    _stateButton.frame = CGRectMake(10, _recordButton.frame.origin.y + _recordButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_stateButton];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_shareButton addTarget:self action:@selector(shareButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setBackgroundColor:[UIColor greenColor]];
    _shareButton.frame = CGRectMake(10, _stateButton.frame.origin.y + _stateButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_shareButton];
    
    _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_editButton addTarget:self action:@selector(editButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_editButton setBackgroundColor:[UIColor orangeColor]];
    _editButton.frame = CGRectMake(10, _shareButton.frame.origin.y + _shareButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_editButton];
    
    _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playButton setTitle:@"播放" forState:UIControlStateNormal];
    [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(playButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_playButton setBackgroundColor:[UIColor brownColor]];
    _playButton.frame = CGRectMake(10, _editButton.frame.origin.y + _editButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_playButton];
    
    _getRecListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_getRecListButton setTitle:@"获取" forState:UIControlStateNormal];
    [_getRecListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_getRecListButton addTarget:self action:@selector(getRecordListClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_getRecListButton setBackgroundColor:[UIColor purpleColor]];
    _getRecListButton.frame = CGRectMake(10, _playButton.frame.origin.y + _playButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_getRecListButton];
    
    _deleteRecListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteRecListButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteRecListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_deleteRecListButton addTarget:self action:@selector(deleteRecordClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteRecListButton setBackgroundColor:[UIColor darkGrayColor]];
    _deleteRecListButton.frame = CGRectMake(10, _getRecListButton.frame.origin.y + _getRecListButton.frame.size.height, self.view.frame.size.width - 20, BUTTON_HEIGHT);
    [self.view addSubview:_deleteRecListButton];
    
    currentState = RECORD_INVALID;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 70, 40, 90, 30)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.backgroundColor = [UIColor blackColor];
    self.timeLabel.textAlignment = UITextAlignmentCenter;
    self.timeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.text = @"0:00:00";
    [self.view addSubview:self.timeLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)_setupMetal
{
    // Find a usable device
    _device = MTLCreateSystemDefaultDevice();
    
    // Create a new command queue
    _commandQueue = [_device newCommandQueue];
    
    // Load all the shader files with a metal file extension in the project
    _defaultLibrary = [_device newDefaultLibrary];
    
    // Setup metal layer and add as sub layer to view
    _metalLayer = [CAMetalLayer layer];
    _metalLayer.device = _device;
    _metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    // Change this to NO if the compute encoder is used as the last pass on the drawable texture
    _metalLayer.framebufferOnly = YES;
    
    // Add metal layer to the views layer hierarchy
    [_metalLayer setFrame:self.view.layer.frame];
    [self.view.layer addSublayer:_metalLayer];
    
    self.view.opaque = YES;
    self.view.backgroundColor = nil;
    self.view.contentScaleFactor = [UIScreen mainScreen].scale;
}

- (void)_loadAssets
{
    // Allocate one region of memory for the uniform buffer
    _dynamicConstantBuffer = [_device newBufferWithLength:MAX_BYTES_PER_FRAME options:0];
    _dynamicConstantBuffer.label = @"UniformBuffer";
    
    // Load the fragment program into the library
    id <MTLFunction> fragmentProgram = [_defaultLibrary newFunctionWithName:@"lighting_fragment"];
    
    // Load the vertex program into the library
    id <MTLFunction> vertexProgram = [_defaultLibrary newFunctionWithName:@"lighting_vertex"];
    
    // Setup the vertex buffers
    _vertexBuffer = [_device newBufferWithBytes:cubeVertexData length:sizeof(cubeVertexData) options:MTLResourceOptionCPUCacheModeDefault];
    _vertexBuffer.label = @"Vertices";
    
    // Create a reusable pipeline state
    MTLRenderPipelineDescriptor *pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineStateDescriptor.label = @"MyPipeline";
    [pipelineStateDescriptor setSampleCount: 1];
    [pipelineStateDescriptor setVertexFunction:vertexProgram];
    [pipelineStateDescriptor setFragmentFunction:fragmentProgram];
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    pipelineStateDescriptor.depthAttachmentPixelFormat = MTLPixelFormatDepth32Float;
    
    NSError* error = NULL;
    _pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor error:&error];
    if (!_pipelineState) {
        NSLog(@"Failed to created pipeline state, error %@", error);
    }
    
    MTLDepthStencilDescriptor *depthStateDesc = [[MTLDepthStencilDescriptor alloc] init];
    depthStateDesc.depthCompareFunction = MTLCompareFunctionLess;
    depthStateDesc.depthWriteEnabled = YES;
    _depthState = [_device newDepthStencilStateWithDescriptor:depthStateDesc];
}

- (void)setupRenderPassDescriptorForTexture:(id <MTLTexture>) texture
{
    if (texture.width == 0 || texture.height == 0) {
        return;
    }
    
    if (_renderPassDescriptor == nil)
        _renderPassDescriptor = [MTLRenderPassDescriptor renderPassDescriptor];
    
    _renderPassDescriptor.colorAttachments[0].texture = texture;
    _renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
    _renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.65f, 0.65f, 0.65f, 1.0f);
    _renderPassDescriptor.colorAttachments[0].storeAction = MTLStoreActionStore;
    
    if (!_depthTex || (_depthTex && (_depthTex.width != texture.width || _depthTex.height != texture.height)))
    {
        //  If we need a depth texture and don't have one, or if the depth texture we have is the wrong size
        //  Then allocate one of the proper size
        
//        NSLog(@"_dethTex.width = %lu, _depth.height = %lu, texture.width = %lu, texture.height = %lu", _depthTex.width, _depthTex.height, texture.width, texture.height);
        MTLTextureDescriptor* desc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat: MTLPixelFormatDepth32Float width: texture.width height: texture.height mipmapped: NO];
        _depthTex = [_device newTextureWithDescriptor: desc];
        _depthTex.label = @"Depth";
        
        _renderPassDescriptor.depthAttachment.texture = _depthTex;
        _renderPassDescriptor.depthAttachment.loadAction = MTLLoadActionClear;
        _renderPassDescriptor.depthAttachment.clearDepth = 1.0f;
        _renderPassDescriptor.depthAttachment.storeAction = MTLStoreActionDontCare;
    }
}

- (void)_render
{
    dispatch_semaphore_wait(_inflight_semaphore, DISPATCH_TIME_FOREVER);
    
    [self _update];
    
    // Create a new command buffer for each renderpass to the current drawable
    id <MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";
    
    // obtain a drawable texture for this render pass and set up the renderpass descriptor for the command encoder to render into
    id <CAMetalDrawable> drawable = [_metalLayer nextDrawable];
//    NSLog(@"drawable.texture.widht = %lu, drawable.texture.height = %lu", drawable.texture.width, drawable.texture.height);
    
    [self setupRenderPassDescriptorForTexture:drawable.texture];
    
    
    // Create a render command encoder so we can render into something
    id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:_renderPassDescriptor];
    renderEncoder.label = @"MyRenderEncoder";
    [renderEncoder setDepthStencilState:_depthState];
    
    // Set context state
    [renderEncoder pushDebugGroup:@"DrawCube"];
    [renderEncoder setRenderPipelineState:_pipelineState];
    [renderEncoder setVertexBuffer:_vertexBuffer offset:0 atIndex:0 ];
    [renderEncoder setVertexBuffer:_dynamicConstantBuffer offset:(sizeof(uniforms_t) * _constantDataBufferIndex) atIndex:1 ];
    
    // Tell the render context we want to draw our primitives
    [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:36 instanceCount:1];
    [renderEncoder popDebugGroup];
    
    // We're done encoding commands
    [renderEncoder endEncoding];
    
    // Call the view's completion handler which is required by the view since it will signal its semaphore and set up the next buffer
    __block dispatch_semaphore_t block_sema = _inflight_semaphore;
    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer) {
        dispatch_semaphore_signal(block_sema);
    }];
    
    // The renderview assumes it can now increment the buffer index and that the previous index won't be touched until we cycle back around to the same index
    _constantDataBufferIndex = (_constantDataBufferIndex + 1) % g_max_inflight_buffers;
    
    // Schedule a present once the framebuffer is complete
    [commandBuffer presentDrawable:drawable];
    
    // Finalize rendering here & push the command buffer to the GPU
    [commandBuffer commit];
}

- (void)_reshape
{
    // When reshape is called, update the view and projection matricies since this means the view orientation or size changed
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    _projectionMatrix = matrix_from_perspective_fov_aspectLH(65.0f * (M_PI / 180.0f), aspect, 0.1f, 100.0f);
    
    _viewMatrix = matrix_identity_float4x4;
}

- (void)_update
{
    matrix_float4x4 base_model = matrix_multiply(matrix_from_translation(0.0f, 0.0f, 5.0f), matrix_from_rotation(_rotation, 0.0f, 1.0f, 0.0f));
    matrix_float4x4 base_mv = matrix_multiply(_viewMatrix, base_model);
    matrix_float4x4 modelViewMatrix = matrix_multiply(base_mv, matrix_from_rotation(_rotation, 1.0f, 1.0f, 1.0f));
    
    _uniform_buffer.normal_matrix = matrix_invert(matrix_transpose(modelViewMatrix));
    _uniform_buffer.modelview_projection_matrix = matrix_multiply(_projectionMatrix, modelViewMatrix);
    
    // Load constant buffer data into appropriate buffer at current index
    uint8_t *bufferPointer = (uint8_t *)[_dynamicConstantBuffer contents] + (sizeof(uniforms_t) * _constantDataBufferIndex);
    memcpy(bufferPointer, &_uniform_buffer, sizeof(uniforms_t));
    
    _rotation += 0.01f;
}

// The main game loop called by the CADisplayLine timer
- (void)_gameloop
{
    @autoreleasepool {
        if (_layerSizeDidUpdate)
        {
            CGFloat nativeScale = self.view.window.screen.nativeScale;
            CGSize drawableSize = self.view.bounds.size;
            drawableSize.width *= nativeScale;
            drawableSize.height *= nativeScale;
            _metalLayer.drawableSize = drawableSize;
            
            [self _reshape];
            _layerSizeDidUpdate = NO;
        }
        
        // draw
        [self _render];
    }
}

// Called whenever view changes orientation or layout is changed
- (void)viewDidLayoutSubviews
{
    _layerSizeDidUpdate = YES;
    [_metalLayer setFrame:self.view.layer.frame];
}

#pragma mark Utilities

static matrix_float4x4 matrix_from_perspective_fov_aspectLH(const float fovY, const float aspect, const float nearZ, const float farZ)
{
    float yscale = 1.0f / tanf(fovY * 0.5f); // 1 / tan == cot
    float xscale = yscale / aspect;
    float q = farZ / (farZ - nearZ);
    
    matrix_float4x4 m = {
        .columns[0] = { xscale, 0.0f, 0.0f, 0.0f },
        .columns[1] = { 0.0f, yscale, 0.0f, 0.0f },
        .columns[2] = { 0.0f, 0.0f, q, 1.0f },
        .columns[3] = { 0.0f, 0.0f, q * -nearZ, 0.0f }
    };
    
    return m;
}

static matrix_float4x4 matrix_from_translation(float x, float y, float z)
{
    matrix_float4x4 m = matrix_identity_float4x4;
    m.columns[3] = (vector_float4) { x, y, z, 1.0 };
    return m;
}

static matrix_float4x4 matrix_from_rotation(float radians, float x, float y, float z)
{
    vector_float3 v = vector_normalize(((vector_float3){x, y, z}));
    float cos = cosf(radians);
    float cosp = 1.0f - cos;
    float sin = sinf(radians);
    
    matrix_float4x4 m = {
        .columns[0] = {
            cos + cosp * v.x * v.x,
            cosp * v.x * v.y + v.z * sin,
            cosp * v.x * v.z - v.y * sin,
            0.0f,
        },
        
        .columns[1] = {
            cosp * v.x * v.y - v.z * sin,
            cos + cosp * v.y * v.y,
            cosp * v.y * v.z + v.x * sin,
            0.0f,
        },
        
        .columns[2] = {
            cosp * v.x * v.z + v.y * sin,
            cosp * v.y * v.z - v.x * sin,
            cos + cosp * v.z * v.z,
            0.0f,
        },
        
        .columns[3] = { 0.0f, 0.0f, 0.0f, 1.0f
        }
    };
    return m;
}

- (void)changeRecordTime
{
    NSTimeInterval d = CFAbsoluteTimeGetCurrent() - _startTime;
    
    NSInteger minute = 0;
    NSInteger seconde = 0;
    if (d > 60)
    {
        minute = d / 60;//分钟数
    }
    seconde = d - minute * 60;//秒数
    NSInteger ms = (d - minute * 60 - seconde) * 10;
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%02ld:%ld0", (long)minute, (long)seconde, (long)ms];
}

#pragma mark - click handler
- (void)recordButtonClickHandler:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [_labelTimer invalidate];
        
        _startTime = CFAbsoluteTimeGetCurrent();
        _labelTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeRecordTime) userInfo:nil repeats:YES];
        
        currentState = RECORD_START;
        //开始录制视频
        [ShareREC startRecording];
        
    }
    else
    {
        [_labelTimer invalidate];
        
        if (currentState == RECORD_PUASE) {
            
            [self stateButtonClickHandler:nil];
        }
        currentState = RECORD_STOP;
        
        //结束录制视频
        [ShareREC stopRecording:^(NSError *error) {
            
            if (!error)
            {
                //结束后编辑视频
                [ShareRECSocial openByTitle:@"这是一个测试视频录像的Demo"
                                   userData:@{@"游戏元素" : @"元素值"}
                                   pageType:ShareRECSocialPageTypeShare
                                    onClose:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:error.localizedDescription
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
            
            
        }];
    }
}

- (void)stateButtonClickHandler:(UIButton *)sender
{
    if (sender == nil) {
        _stateButton.selected = !_stateButton.selected;
        return;
    }
    
    if (currentState == RECORD_START || currentState == RECORD_RESUME) {
        currentState = RECORD_PUASE;;
        sender.selected = !sender.selected;
        
        [ShareREC pauseRecording];
        
    }else if (currentState == RECORD_PUASE){
        currentState = RECORD_RESUME;
        sender.selected = !sender.selected;
        
        [ShareREC resumeRecording];
        
    }
}

- (void)shareButtonClickHandler:(UIButton *)sender
{
    //打开视频分享界面
    [ShareRECSocial openByTitle:@"我在游戏中得了2000分，求超越"
                       userData:@{@"score" : @(2000)}
                       pageType:ShareRECSocialPageTypeShare
                        onClose:nil];
}

- (void)editButtonClickHandler:(UIButton *)sender
{
    [ShareREC editLastRecordingWithTitle:@"我在游戏中获得2000分，快来看看哦"
                                userData:@{@"score" : @(2000)}
                                 onClose:^{
                                     NSLog(@"==== close");
                                 }];
}

- (void)playButtonClickHandler:(UIButton *)sender
{
    [ShareREC playLastRecording];
}

//获取
- (void)getRecordListClickHandler:(UIButton *)sender
{
    //获取本地视频列表
    NSArray *recordings = [ShareREC currentLocalRecordings];
    NSLog(@"本地视频 = %@", recordings);
}

- (void)deleteRecordClickHandler:(UIButton *)sender
{
    //    //清空本地视频列表
    //    [ShareREC clearLocalRecordings];
    
    //单独删除
    NSArray *recordings = [ShareREC currentLocalRecordings];
    SRERecording *recording = [recordings lastObject];
    if (recording) {
        [ShareREC deleteLocalRecording:recording];
    }
}

@end
