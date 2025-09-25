Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA061E0DD9
	for <linux-hardening@vger.kernel.org>; Thu, 25 Sep 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826461; cv=none; b=hnzPYENTc5gTV+oLDyrlbcqG1qABQ3FnMgnJoZTEUo5kpPICO3z9TO4sgrBgpFcaDRQ3ChW12HKLvqtUH1JLYVoKUQnks84/4EBJDgwDlKSf2Sl0CENeXNWTrlEOKR2C2lEycJxNmF2gYpib7koD4rUJlv+BdHDref0WIxVfKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826461; c=relaxed/simple;
	bh=S65qoyQlnm2r8ff5IZRLqdLCqlrBfgBhfTzbt3oEUow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOCaAtrT913YibHq+djN7jpy5gbYSDAd78cfE1PVtu1wu3IWrmmt4k6OJlkl/Db+V8shvKHQHZGJ2wACMAhPGwe8GywxFxOIXm61hYFD5rBGiQTuyFsQZ1MeMBK2gLZVMNBx0Ew8rNipH87AOUYFrhwZP7iEiZVTyPtljUax52s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=d4EqFZXQ; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="d4EqFZXQ"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 1nTTv3GF3aPqL1r6hvNg1e; Thu, 25 Sep 2025 18:54:19 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 1r6evtKoBfhew1r6evhPKb; Thu, 25 Sep 2025 18:54:16 +0000
X-Authority-Analysis: v=2.4 cv=Q+TS452a c=1 sm=1 tr=0 ts=68d58fd8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=kbmabLdzh3uUJaiPGAIkPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7T7KSl7uo7wA:10
 a=DteqQ0MXNSPvLnE5JQEA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ReuDuMaujN0MhhBVHybap8vk7TKVWSfnnUBsXonGP2s=; b=d4EqFZXQyUecheMwwfXlO3iqFj
	Vs0i/dhEVEVNkd45SBZmSDIcxb5lpEq3DawVSdetan4LiFIaLnML1NFEbtzlAreQX/M0d5kvxfQHK
	Y2nQyUyfsKJiVlllhF3Mi0D557I8qRtyAEW2TnEPyxh6uAv3xo2LIyKHlmgNL68zzh9xXBIcT1iL6
	y18QopIvIAgCkVjvKKzrI/iMIveCM4d0XXy/0qoAgGDM3TZqx3iQm8ugVv7zrkLxneUYEy91K2e+G
	I8Jd8NdQFb1InpceN3c5Inx7OYAkLct3our8vZpl3GKGQwuCtmGR2FS9eKmzYTNdlPqOffBmn1kZ+
	lyEdKiEQ==;
Received: from [83.214.221.223] (port=56964 helo=[192.168.1.104])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1v1r6a-00000000Pwc-3iFY;
	Thu, 25 Sep 2025 13:54:13 -0500
Message-ID: <39cb2084-db12-461d-8c9b-17fd48d5c682@embeddedor.com>
Date: Thu, 25 Sep 2025 20:54:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] scsi: qla2xxx: zero default_item last in
 qla24xx_free_purex_item
To: Bryan Gurney <bgurney@redhat.com>, jmeneghi@redhat.com
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com,
 njavali@marvell.com, linux-scsi@vger.kernel.org, hare@suse.de,
 linux-hardening@vger.kernel.org, kees@kernel.org, gustavoars@kernel.org,
 emilne@redhat.com
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
 <20250925170223.18238-1-bgurney@redhat.com>
 <e58d743b-a999-4e00-8f2e-31707744c5bb@embeddedor.com>
 <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <CAHhmqcTdC_we4x9e0Q-NT=k-9LM5Q8azFH51_Wbpr4tKgpOzDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 83.214.221.223
X-Source-L: No
X-Exim-ID: 1v1r6a-00000000Pwc-3iFY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.104]) [83.214.221.223]:56964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfD7AcVpYXXDFbaNjKcCPZ+83k9iclfEIjMPf16kZfvYt3n0lDm/isahG0n3/ay5SBIcqYJ8Fes1wa5iv2VKvRIhW0SM8zMquzZ9eFVkxrTuwQAoizwO6
 NJhG5GJlDhKDdhPNBBN7vC0tySdnu7iHFSFlp/jPZtzYDPZglu9FdWNJk41hSSnzbpoLQ1scyRJZthsucwt2kV5fOXTSqcZzM0MSxoSzYOhPzq89diAvP5Lm


>> I see. I think it's probably better to go ahead with the revert, and then apply
>> the patch I proposed in my previous e-mail (it's more straightforward and introduces
>> fewer changes).
>>
>> If you agree with that, I can submit both the revert and the patch.
>>
>> Thanks
>> -Gustavo
>>
> 
> Hi Gustavo,
> 
> I just built a kernel with your patch, on top of the NVMe FPIN link
> integrity v9 patch set, and a test run on qla2xxx passes without any
> field-spanning write warnings, nor with any null pointer dereference
> errors.


Awesome. Thanks so much for testing it, Bryan. :)

Okay, so I'll go ahead and ACK the revert submitted by John (so as not
to duplicate efforts), and once it's applied, I'll submit the proposed
patch.

Thank you, folks.
-Gustavo

