Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668A171B8
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horotw.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horotw.com
Received: from mors-relay-2501.netcup.net (localhost [127.0.0.1])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4TDCZ1227kz61CQ
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 14:25:29 +0100 (CET)
Authentication-Results:mors-relay-2501.netcup.net; dkim=permerror (bad message/signature format)
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2501.netcup.net (Postfix) with ESMTPS id 4TDCZ11JKdz4xMB
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 14:25:29 +0100 (CET)
Received: from mx2fc9.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TDCZ058MQz8sb0
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 14:25:28 +0100 (CET)
Received: from webmail01.netcup.net (unknown [46.38.249.153])
	by mx2fc9.netcup.net (Postfix) with ESMTPA id 3C590805DC
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 14:25:24 +0100 (CET)
Authentication-Results: mx2fc9;
        spf=pass (sender IP is 46.38.249.153) smtp.mailfrom=mail@horotw.com smtp.helo=webmail01.netcup.net
Received-SPF: pass (mx2fc9: connection is authenticated)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jan 2024 14:25:24 +0100
From: mail@horotw.com
To: linux-hardening@vger.kernel.org
Subject: Limited/Broken functionality of ASLR for Libs >= 2MB
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <69fa6015256613ed10aee996e181ebd4@horotw.com>
X-Sender: mail@horotw.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <170532512442.2091.6149408532718822696@mx2fc9.netcup.net>
X-Rspamd-Queue-Id: 3C590805DC
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: xqCj4REgWOdHBw3GODjFgojjZZCAP8KOztTvIEVXbQ==

Hey, I read that ASLR is currently (since kernel >=5.18) broken for 
32bit libs and reduced in effectiveness for 64bit libs... (the issue 
only arises if a lib is over 2MB).
I confirmed this for myself but only for the 64bit case.

I saw that this issue is being tracked by ubuntu 
(https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1983357).
If this is the wrong place and I should instead report it elsewhere I am 
very sorry.

Sources:
https://zolutal.github.io/aslrnt/  # the page of the original discoverer 
of the bug - as far as I know
https://infosec.exchange/@wdormann/111744168574317113

How I checked that this issue is present (I used bat because it includes 
libcrypto which is a lot bigger than 2MB and not on the edge of 2MB like 
libc):
```python
from subprocess import check_output

def check_bit_usage(cmd):
     res = 0x0
     for _ in range(0, 1000):
         out = check_output(cmd, shell=True).decode()
         base_address = int(out.split("-")[0], 16)
         res |= base_address
     return hex(res)

result = check_bit_usage("cat /proc/self/maps | grep ld-linux | head 
-n1")
print(f"Result for ld-linux (smaller than 2MB): {result}")

result = check_bit_usage("bat /proc/self/maps | grep libcrypto | head 
-n1")
print(f"Result for libcrypto (bigger than 2MB): {result}")
```

Output:
```
Result for ld-linux (smaller than 2MB): 0x7ffffffff000
Result for libcrypto (bigger than 2MB): 0x7fffffe00000
```

This is my first time reporting an issue to the kernel so if anything is 
inappropriate please let me know.
