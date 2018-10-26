Pod::Spec.new do |s|

s.name         = 'PGSwiftExtensions'
s.version      = '1.0.0'
s.summary      = 'Swift工程基础拓展'
s.description  = 'Swift工程基础拓展'
s.homepage     = 'https://github.com/PrettyGrass'
s.license      = 'COMMERCIAL'
s.author       = {
                'renxun' => '490282258@qq.com',
                'ylin.yang' => 'y0love@163.com',
}
s.platform     = :ios, '8.0'
s.source       = {:git => "https://github.com/PrettyGrass/PGSwiftExtensions.git", :branch => s.version.to_s }
s.requires_arc = true

s.source_files = 'src/**/*.{swift,h,m}' 
s.dependency "SwifterSwift/Foundation" ,'4.5.0'
s.dependency "SwifterSwift/UIKit" ,'4.5.0'

end

# !!!!end 后一定记得要有换行



