// Flutter Web 启动脚本
// 用于解决CORS问题并初始化Flutter应用

// 设置CORS头部
function setupCORS() {
  if (window.dev_mode) {
    console.log('设置CORS支持...');
  }
  
  // 为API请求添加CORS支持
  window.addEventListener('fetch', function(event) {
    if (event.request && event.request.url && event.request.url.includes('127.0.0.1:8080')) {
      // 对API请求添加CORS头部
      const modifiedRequest = new Request(event.request, {
        mode: 'cors',
        credentials: 'include'
      });
      event.respondWith(fetch(modifiedRequest));
    }
  }, true);
}

// 主启动函数
async function bootstrapFlutter() {
  // 设置CORS
  setupCORS();
  
  // 等待Flutter主脚本加载
  if (window.dev_mode) {
    console.log('正在加载Flutter应用...');
  }
  
  try {
    // 动态加载主Flutter脚本
    const mainScript = document.createElement('script');
    mainScript.src = 'main.dart.js';
    mainScript.type = 'application/javascript';
    document.body.appendChild(mainScript);
    
    // 添加错误处理
    mainScript.onerror = function(error) {
      console.error('Flutter应用加载失败:', error);
      document.body.innerHTML += '<div style="color:red;padding:20px;">Flutter应用加载失败，请检查网络连接和API服务是否正常运行。</div>';
    };
    
    if (window.dev_mode) {
      console.log('Flutter脚本已添加到DOM');
    }
  } catch (error) {
    console.error('启动过程中出错:', error);
  }
}

// 设置调试模式
window.dev_mode = true;

// 启动应用
document.addEventListener('DOMContentLoaded', bootstrapFlutter);