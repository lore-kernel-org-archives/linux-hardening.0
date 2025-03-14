Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0531D530
	for <linux-hardening@vger.kernel.org>; Fri, 14 Mar 2025 00:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913287; cv=none; b=e/S4J6HJ/mPKujDUW5kmcKPSavNDZStMTvLfAb6ATTIIn85U4IfHRmRx7SELv9xPCIrSrzXhLeyJ3iygSITjJE+Z6tW0iPWsdo8a4PSKMGCtVX3GWsWJPW+/sD9t64DIM0n2t59uvvuamHUNdUjjRhBmaZ51EtQNYnGEbhrhmBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913287; c=relaxed/simple;
	bh=TQD3AJzqUtfxU2ZtBhJ0LHa7vvbXsj3A7BUF66xhl54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d36Ah8BzqFke3uBQzZAlAfDsohz4mTsHN8jbWNfbRVyCRhKebJyWc+LlxzaIVtW8msyT9zUdnM7NEQDtpCc9RY1xOHMGfGIcfidccYGBjq0cpDE5lpx84QxZPu1TXCw+ydDdEzAuxgE0vVlSqycx6qvLmeuSXy8ZcSzC4XYUmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dIRn+R1+; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dIRn+R1+"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id srsKt8jozVkcRstDTtfJRm; Fri, 14 Mar 2025 00:47:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id stDStJQKeoI0jstDStYjo3; Fri, 14 Mar 2025 00:47:58 +0000
X-Authority-Analysis: v=2.4 cv=TMBDSUla c=1 sm=1 tr=0 ts=67d37cbe
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=pCqRpgb2EoSYttADf5oA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ygi1TZ6kTOz8skaSiNhkQe8V1nGHCFg15P5UFWzKVtc=; b=dIRn+R1+T7USvNbetrG28jIkaJ
	AskPcM/0W8kW3KrF8bJDtUpJzXJEIk1hniRexG2VXo5MzhVGwcru0Jek7y5z6s28+ov7Zko3Y5sBZ
	SQcCYWVU+q8uuxzmfKJQYEd/ys2JwqAfCHZEcluR5gAPrhkw3fm0cbNq9gIkYJZLnckKZschBHLCG
	F5z2Rmg/18OfejD5EGOBHCC334f5l2tDbiGQWkAFPxe+v6a/xy1vAtbrowyC0WPpgyNDqjkSmHSFe
	/oc8OcxJdr7Vx1img6Gd5qvvCiTFNfc5Vt1xtBlOM+B9azal4g4SRXeDMI2KidIzLancF62/zFU1E
	OPx0RBGQ==;
Received: from [45.124.203.140] (port=53636 helo=[192.168.0.159])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tstDQ-00000003GmM-3ZZ4;
	Thu, 13 Mar 2025 19:47:57 -0500
Message-ID: <63d0cca7-b095-4762-8ec4-5004e5c6bad1@embeddedor.com>
Date: Fri, 14 Mar 2025 11:17:45 +1030
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rtc: Avoid a couple of -Wflex-array-member-not-at-end
 warnings
To: Tzung-Bi Shih <tzungbi@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-rtc@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z851qvkycepdNlBd@kspp> <Z9EZByipsNmBoVea@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z9EZByipsNmBoVea@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tstDQ-00000003GmM-3ZZ4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.159]) [45.124.203.140]:53636
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB58mPLaFTL+5SXobgvDCscIrl1nmQBY4dE/yBuodmy5QmFeJOIfwVLNM6uIoNS3ZcmT9vMeM/cKGU5D0iG+3ioxG4hjGcTDj5ZHK17LA5hse5sOpmPN
 linlWbXRmrZQwK1ygcqQZSp1ZOnKyPLg/+hvdQa5ynBf6sye8T85DcBG6euZFvNte5W42Xg0nn9XVDmInUphQ57EdUIZuFGseDo1xE0yVnb0b6tSZDul5Goa


> I'm not a big fan of the solution.  How about using something similar to:
> 
> struct cros_ec_command *msg = kzalloc(sizeof(*msg) +
>                                        sizeof(struct ec_response_rtc), ...);
> 

Thanks for the feedback. :) We can actually use DEFINE_RAW_FLEX():

https://lore.kernel.org/linux-hardening/Z9N8BsVJF-s6Hcvd@kspp/

--
Gustavo

