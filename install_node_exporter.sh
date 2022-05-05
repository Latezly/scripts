Scripts_Version=1.0
Node_Exporter_Version=1.3.1

cd /tmp

echo "下载Node_Exporter"
wget -q https://github.com/prometheus/node_exporter/releases/download/v${Node_Exporter_Version}/node_exporter-${Node_Exporter_Version}.linux-amd64.tar.gz && echo "完成" || (echo "失败";exit 1)

echo "解压Node_Exporter"
tar -zxf node_exporter-${Node_Exporter_Version}.linux-amd64.tar.gz && echo "完成" || (echo "失败";exit 1)

echo "安装Node_Exporter"
mv node_exporter-${Node_Exporter_Version}.linux-amd64 /etc/node_exporter && ln -sf /etc/node_exporter/node_exporter /usr/local/bin/node_exporter && echo "完成" || (echo "失败";exit 1)
echo "创建Node_Exporter服务"
cat > /etc/systemd/system/node_exporter.service << EOF
[Unit]
Description=node_exporter
Documentation=https://prometheus.io/
After=network.target
[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/node_exporter
Restart=on-failure
[Install]
WantedBy=multi-user.target
EOF

echo "启动Node_Exporter"
systemctl enable node_exporter
systemctl start node_exporter