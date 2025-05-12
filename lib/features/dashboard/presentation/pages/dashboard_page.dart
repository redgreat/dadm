import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // 年度里程数据
  final locationYear = '-';
  // 年度财务数据
  final financeYear = '-';
  // 年度睡眠数据
  final sleepYear = '-';
  // 年度心率数据
  final heartYear = '-';
  
  // 周平均里程
  final locationWeek = '-';
  // 周平均步数
  final stepsWeek = '-';
  // 周平均睡眠
  final sleepWeek = '-';
  // 周平均心率
  final heartWeek = '-';

  @override
  void initState() {
    super.initState();
    // TODO: 获取仪表盘数据
    // 登录成功后显示提示
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('登录成功'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('仪表盘'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 第一行卡片 - 周数据
              Row(
                children: [
                  _buildWeekCard(
                    icon: Icons.directions_bike,
                    title: '平均里程',
                    value: locationWeek,
                    color: Colors.teal,
                  ),
                  _buildWeekCard(
                    icon: Icons.directions_walk,
                    title: '平均步数',
                    value: stepsWeek,
                    color: Colors.green,
                  ),
                  _buildWeekCard(
                    icon: Icons.bedtime,
                    title: '平均睡眠',
                    value: sleepWeek,
                    color: Colors.grey,
                  ),
                  _buildWeekCard(
                    icon: Icons.favorite,
                    title: '平均心率',
                    value: heartWeek,
                    color: Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 图表区域
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Container(
                        height: 300,
                        padding: const EdgeInsets.all(16),
                        child: const Center(child: Text('年度里程图表')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Container(
                        height: 300,
                        padding: const EdgeInsets.all(16),
                        child: const Center(child: Text('年度财务图表')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // 年度数据卡片
              Row(
                children: [
                  _buildYearCard(
                    icon: Icons.directions_car,
                    title: '年度里程',
                    value: locationYear,
                    color: Colors.blue,
                  ),
                  _buildYearCard(
                    icon: Icons.attach_money,
                    title: '年度消费',
                    value: financeYear,
                    color: Colors.green,
                  ),
                  _buildYearCard(
                    icon: Icons.hotel,
                    title: '年度睡眠',
                    value: sleepYear,
                    color: Colors.grey,
                  ),
                  _buildYearCard(
                    icon: Icons.favorite,
                    title: '年度心率',
                    value: heartYear,
                    color: Colors.orange,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(title),
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.calendar_today, size: 16),
                  SizedBox(width: 4),
                  Text('7日内'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYearCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
