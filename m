Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB857874
	for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885596; cv=none; b=p6clDHH4OPJKb9fo05ZVGY81jxwsEoE7Vzh7FtXWuzBUO5hSsUg2gRxfwuebFJtK0k98HNh4Jj0Pr8Lch7Tko6zLBTrPrjEfRjJRXJ0nMI3sZMJMelRXMP1pg8v2/m0xzOYGQmHGmGgPsN1jJ7m6sTeP4cnz4cz2tQJCAqjFQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885596; c=relaxed/simple;
	bh=H8Xrsy5U5+wjhhNb3k1yzO5Le2BGI9DJIm2JbPyMiPo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=is26guvzevnDraa/QywQgchDX8ZFDdg/utUIgEI/VZCq4aSET/TwVkf++BpJd2b0I6ftgBW0ZKTAbByvqxArNVUEH+HGU8APRiYV+1Co/cjFkvQh2DhDPekwAfNE0/7K/ngie5nmae8BZ2K5zvgZyCmodiS3L0W5+eEOw/C2abU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=lmsTIh8O; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="lmsTIh8O"
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id mJh3rfLJNPM1hmhUvrZE5m; Tue, 19 Mar 2024 21:59:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id mhUurY4xaELAWmhUvrp32p; Tue, 19 Mar 2024 21:59:53 +0000
X-Authority-Analysis: v=2.4 cv=EfzOQumC c=1 sm=1 tr=0 ts=65fa0ad9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=_DBm1pjlkuoUrYqYS5sA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:Subject
	:From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f0krBtkpln32MXoQmq95Gq5x0JcF1a1nYnnue0D1jeU=; b=lmsTIh8O5qSO3jeXov0b4WExRQ
	Fdu5Sa4EjSN99CDzRLdxiSCFMcQR/COSpXCG6Li+4ainJ81q/XBTs6T5nOnKGVx+YgfPNfpTQST3V
	DOvWvpzTKaZKCrjlVs6BFOdZMPOKM3JPr+EDtUpzhq3VWkM/+P7ePsZt7rUWazVnoblzHXa3Zldo1
	lryARRR8tEa3VkDU2UHKNlszSuDsub/ML/+mo3MC8HFrvSkHClXSQbHOzPAdGPJFwroPAomd7cB8s
	0I0ZB2PnuSDXPUrAmLiBi4N+Kav5DeljtYyttBUkXj4UCkyMEu74Rujq5xnh96hgfiIOMELMCXlly
	FE78p3pA==;
Received: from [201.172.174.229] (port=55934 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rmhUu-004MPP-1b;
	Tue, 19 Mar 2024 16:59:52 -0500
Message-ID: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
Date: Tue, 19 Mar 2024 15:59:51 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RFC] wireless: ti: Can we just remove this flexible array?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rmhUu-004MPP-1b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:55934
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKApuJMELJ50aNDpZwcIQsvglfih3s4i1Zvz9uIIdbNJPKVrFdA+L5kRAiE5tPw3ZiUWxtdUQ59laN62pudaLmU0zKylElHMv9c1w4ruSU3M3LLOFJyn
 oFFLs3FdEEKScEz5kruhfS83j0bQl8xzNHyX7j9X3IO0kjyvPmmkIuSiIel5ZWgayWNVn3U2aCYaL+m8TMEAph2pPssE4ws1MyOo0S6WcUEId2+RgrRcaqRr

Hi!

`struct wl1271_cmd_header` is currently embedded in multiple other
structs, and it's causing many `-Wflex-array-member-not-at-end` warnings.

Has this flexible-array member been used in the past or is it intended
for future use?

Otherwise, I think we could just remove it.

diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
index f2609d5b6bf7..4c2f2608ef3b 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.h
+++ b/drivers/net/wireless/ti/wlcore/cmd.h
@@ -208,8 +208,6 @@ enum cmd_templ {
  struct wl1271_cmd_header {
         __le16 id;
         __le16 status;
-       /* payload */
-       u8 data[];
  } __packed;


Thanks!
--
Gustavo
