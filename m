Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB124768FD
	for <linux-hardening@vger.kernel.org>; Thu,  3 Oct 2024 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982850; cv=none; b=ffVEpRrxLP7rdTVPolFWYhZ5bs1/5Wfm/J8FqZUXchPJFBYqQsxG2L+/YVA2EeagUPlSPTVROssSkrluFy15jCss/LRMeudPWH9kQ8fFiPkH8G1J5TDFAGjpBMz+bijxml1jZMe6wXXEHOvsZ0G3mt+vSDQstALxlMf1sjLRfUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982850; c=relaxed/simple;
	bh=nvgZo8v/XwYx8CMN/Kd1Zf4q3oflbE/LLAS2ci7oBH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDZ28zJsfwGFlZYvtV1+69Bs9Ct4pGL0bbIuW2lEHzda4GS5jvxY/7//V4EAsYdy0fYwaWTr8mWTOPmyjUMyJ4/JeHzp9TK+LujrtYjWLzbUKp6DrOzf3CAbKHJqFTarO9OggDSjkz4+T/Nf8HiTFp4Hvxg5USom/9o7U/1ey6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=KpKctKFK; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KpKctKFK"
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id w2TdsMwZNiA19wRH0s4kmD; Thu, 03 Oct 2024 19:14:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id wRGzshxUW0HwOwRGzsZtxL; Thu, 03 Oct 2024 19:14:01 +0000
X-Authority-Analysis: v=2.4 cv=HtNwGVTS c=1 sm=1 tr=0 ts=66feecf9
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=B3fuDwYyW55wTQKIj88FGw==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=BXEf9FEPToR6foY5dqUA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8pMJywXUdYNAihC5TeN69Uh5MH5fG8t9KLIBI2MlI90=; b=KpKctKFK35P0YCMvSWT+sDdjBR
	S49MB/OwSRxhMHyKQzkm4mLkOY0yZHshVfRBf0AY0BFViLUNC08SO8w1jXjl7y+0KzB9DFdj+vbPw
	MmAGihM9RAA3YEMgGTcd6+ilQw5AKaai3h7xjfPDQQ0ANcVxXAWYkKGPpfBUM5W8wS7WdRRQ+pdAc
	JFL8R+8EWyIaw5eu45YKh8hS06cB2Yt3X2bLkTkyT5ftdpfv9Xabi3y9V9qnMIqbx9R4ZJz8hSJMu
	MMJz5IZDwQvgp7IakU5sBGIJJ9upuZllwauGX34r35lvqfIaVqM9mFR5YjNBwQUhj/nWlsq4RQm+o
	wEU8h5Uw==;
Received: from [201.172.174.147] (port=34444 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1swRGy-001ha2-1j;
	Thu, 03 Oct 2024 14:14:00 -0500
Message-ID: <a276cecb-ae71-4ae2-8c9b-362403dbc367@embeddedor.com>
Date: Thu, 3 Oct 2024 13:13:58 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau: Avoid -Wflex-array-member-not-at-end
 warning
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZsZLFS1CsHkKjw+C@elsanto>
 <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com>
 <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org>
 <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org>
 <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
 <e9a05386-54d8-4a18-8b16-4e871de094a4@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <e9a05386-54d8-4a18-8b16-4e871de094a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.147
X-Source-L: No
X-Exim-ID: 1swRGy-001ha2-1j
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.174.147]:34444
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBoJkDmdQY1hUqHoeYIvViUdoMYzwN6BmBiGMuxJWG6WH5hzRgAB2SV1u1tVaDALTVW5cckjI4oPmQZ+Q+MO+e3c1KrICheFcXa/fHYpARyMGjVzIwH4
 /2iyKus3dO4vw1caklK4EgrUWlaD1XG1/Am/Obnbb6VGM4YMW0QHfmEEoSds0IX5bIvlzeloeis0wCIMyBAPQQo2xCnrQv0+ASt09FucjiWD9Jvp0uU1aeRL


> 
> Yes, it's not great, but I think it's better than having the length in two
> places.

Agreed. I'll respin. :)

Thanks
--
Gustavo
