Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443E18BC3D
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808021; cv=none; b=flRWqIsMZb/9HJiDPzFUev5CJ5HS8p8VF7dTn63Ml7AwmK499tWe9ODlXzNtpWxPU4j8b03vTwxh1PGT060CrSOHrXESoAz4DJitsrJlRPw+4ZD1xV8Is/gQmtcc/lzrQPUsVq13voN2B8qW8T9rPFeVeOKV8aw4/HQWDc7QbHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808021; c=relaxed/simple;
	bh=QaeuqU5IKDB5njifOO3nkb72eo9WDM+qBuUVP7jeOes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=phZMkp2loSv5hD7PNfk29s8rnORjJOs5xOXI3mMXsTzPDsB8685DoSeM8E9oRetm+34X0L4scS+Wp6jlEkRYpDREhTu6+DfBXDIzyXgNVtDKU0Tf25xWND3Unn1BEcPnF0Z3tr9eV8h/979zT5fsnpQAwXxWL6Qn1SKcelFfHAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=vw0i9OJl; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="vw0i9OJl"
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id 1f1Sv0c8waPqL1mJHvJvWM; Thu, 25 Sep 2025 13:47:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1mJGv0xBsfjrX1mJGv7BiI; Thu, 25 Sep 2025 13:46:58 +0000
X-Authority-Analysis: v=2.4 cv=ItcecK/g c=1 sm=1 tr=0 ts=68d547d2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=TDP2S4RWD7HzL5QBIXWMeQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=Ab0Lm24STF9_9LFwZLUA:9 a=QEXdDO2ut3YA:10 a=DY-CUodvXd4A:10
 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wQH2YqZrAjDbl97Li4x21PKe2sTxB46h35TNYvK8pds=; b=vw0i9OJl5mtBvBE4C/EzxX87dD
	ydfS5gFzKTek3rt2L9X1MMsJD9dFR3TQ7OYTLyCzTKNQ9cUtChg6y9eUxCWnzcDrqnXmiETB9mg7g
	FzwGLriMpthnaMHSy/cz9jq3hS0q8C0yG/lzn8emnqnJYeXQNyyEZNUvSUKImI+QLCRAp7rVL21Fq
	yL/ew+OGyWyW5LH940mUk4XMAiFwFlteMUTg+TrgvLUOBxrpUkT4kNidd13BLnEOlAMdChT2U0uBa
	VNKuL4M/VPhh7kQTewN423cfHG31gBHWPk9F8DNLISY1Fi+wVfX1/ljxfQ8Cl5Ii1kt6XSyO1K0Zx
	CSgSt/qw==;
Received: from [83.214.222.209] (port=33238 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1mJC-00000004B6y-2Lzb;
	Thu, 25 Sep 2025 08:46:55 -0500
Message-ID: <92c454f7-9138-4de5-8857-92970a9cfcf0@embeddedor.com>
Date: Thu, 25 Sep 2025 15:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
To: luiz.dentz@gmail.com, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aMAZ7wIeT1sDZ4_V@kspp>
 <175880760625.2984149.17268227498282852314.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <175880760625.2984149.17268227498282852314.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.222.209
X-Source-L: No
X-Exim-ID: 1v1mJC-00000004B6y-2Lzb
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.222.209]:33238
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIkWEw/w8UC8LNAnGbl5ONzb265BTsoFPM3T5Wih0o5DbtKEIzQbuxzTK7gRTCjrwHF2Mes8NvbDjCmQqQcL6arLZasaWOY7TpnDLQcAxbzjuhPS7PCx
 vc9JI/AKbDZLy2w0/+dz+sihfmD99GKRi5zQ6OywgA2xZudOcHJI3AUkU6/GOr/V5oojQvv6BN8P/teJBP2rMHzl+c8I2AAEekbW+zKQpX4xcvLvlPCmASbN



On 9/25/25 15:40, patchwork-bot+bluetooth@kernel.org wrote:
> Hello:
> 
> This patch was applied to bluetooth/bluetooth-next.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

Thank you, Luiz!

-Gustavo
