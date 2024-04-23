Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58B13CFA4
	for <linux-hardening@vger.kernel.org>; Tue, 23 Apr 2024 21:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907617; cv=none; b=A7mOWqOq79zcQWXxBrxGuQUd1Cj2kSaYPnZ+zLSJWiTuQ88a/1JyHSa3ExVi+c7RgEdLYuyZTBwrWWy2neBU4+BL9etii1MfXapDLD+z8M6/QG1MARJKoFoeknk+Qk8So2QwLfgfuEieJyAL1XnLzDfYYye5XrXjy3pz5Orh4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907617; c=relaxed/simple;
	bh=AR4/jfl18d1BrNGvop+qwiaQnL9UlAgiNSZUFkUuPkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eohB+LPzgHu33MqrflwLEUHXjLxrHxb3ExLIE08RymDPsy0sirIZe70LzXAi1MApllUhyaPBVs0e/7eegwDndhD5d2OKP5xtdQbf6VI4LCl6scoQzR4pzNAIfyQYoBoxCcjasuth9aNDOCjkALLL+XtpTNXd9cLRBuV98Sn8/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=l08TqcJ3; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="l08TqcJ3"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id zE8frlRTutf2QzNfErXuvF; Tue, 23 Apr 2024 21:26:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id zNfDrZIrvUeRwzNfDr9nne; Tue, 23 Apr 2024 21:26:55 +0000
X-Authority-Analysis: v=2.4 cv=B5+/0vtM c=1 sm=1 tr=0 ts=6628279f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Sfg9OT4WXbNM99GaDXVDBA==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=wYkD_t78qR0A:10
 a=VdDABtCXyk9SiVsiCNMA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AwENOt2jGw9fqo5gAkt7vsoIvQip3Njh2Yjyg0AisJ8=; b=l08TqcJ3vWK9Wbr79qe0LKF9pk
	/UJRjVPioyW4djkhv7WQgP6YIOo/Uqi7x1GunjpStme8J2jG0ltsOeEIvwKwOvxsxtlmhTTVqLev0
	93tqWOfrGtVNHzv5cLn+EZEXms//gISVtrYurCM5KiIfT4Rnvr3k4iBkJB+ehB9MQ4CivF0LTzZ/2
	U0oYelpSUWSqvnED/SgmJZEAwrkec2xCuxT2Q0vjqvBFtI6IQx7Ochy8qFI9j1ogo0Zcwni/U3q+G
	3StbiX5bHRxlg4WQKW4sKzZQm2VcCm9mOxxgIuNphMpO6GTk3hCtYimXYEpSR6v8u6X+E41+Cv1a9
	qRYkP2tw==;
Received: from [45.167.200.115] (port=1190 helo=[192.168.5.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rzNfA-002j2b-2J;
	Tue, 23 Apr 2024 16:26:53 -0500
Message-ID: <509125aa-9f92-438c-9a18-2cf3400d7194@embeddedor.com>
Date: Wed, 24 Apr 2024 07:26:30 +1000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] smb: smb2pdu.h: Avoid
 -Wflex-array-member-not-at-end warnings
To: Steve French <smfrench@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <ZhgDTj1nwLEtSd9h@neat>
 <1166494b-3e34-4919-9998-141540a948b3@embeddedor.com>
 <CAH2r5msZaV1kHqQw8Sb_3wQfGBj4aU+tSCR5E0YJ8fCH6ODB4Q@mail.gmail.com>
 <7789881d-a709-48f4-8c14-259acbce813a@embeddedor.com>
 <CAH2r5mu=HYqSnT3j=mdLA7XPyha5A27tBqzJcEZfMAU-yLunbA@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAH2r5mu=HYqSnT3j=mdLA7XPyha5A27tBqzJcEZfMAU-yLunbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.167.200.115
X-Source-L: No
X-Exim-ID: 1rzNfA-002j2b-2J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.5.44]) [45.167.200.115]:1190
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGo8DoSxWExrwv6fsv8uKFF/NmLCZ9gLjbLWxCFxAuAg7sq7aEqxZanev/wsptImbOvacVETBwVHuvO+Pk9ARwWBdiXSyTo1CgSxbXfp6+FDbKf1GAKO
 0wduGnEYwO0BeEeW3xKhoceuvyi9sUyAt7nDJgyB1DVvmpg3zkpR74xcMLGAwJ8xrL+e8Ncw/NV9xO5TF1Wx4RYJBOLTEXKS2RCFhAw+Uuwp7UeYRat5z+3D


>> The _packed in the commit 0268a7cc7fdc is not an attribute, it's the name
>> for the group. So, it's not actually doing what the submitter thinks it does.
> 
> Do you want to submit a followup fix to fix this?  Or let Namjae fix it?
> 

The fix is correct. I'm sorry, I confused the suffix `_attr` with `_tagged` in
the struct_group() family of functions.

I've been in airports the last 24 hours, and I my brain needs some rest.

Thanks!
--
Gustavo
