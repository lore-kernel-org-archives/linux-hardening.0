Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1A154BE7
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jul 2024 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653975; cv=none; b=ZcTT7Y8452GTaEhFQo9zy/A3rWjm1dEElGv26zArLESpUPyF3iC06Pjg/mmSU0CjnBiKX27NJgfwrp8Eqb4+Cm+Dv7Sn+2jDbAql+D7C6xAzeLd83GUn+Trb+5HwulkLGHxcDWgMbEDy1IJr8OPCS0VCjVAxAtxN3Ve2JsCxuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653975; c=relaxed/simple;
	bh=jJuojDJkKVM0mSdix5fpD3/fkoozXZpH2UoKNPWTDZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZ0rKdBV0HiceR8RrMvour7BoG5goS1LPoxN4/dEipnlnYoFD//UwPVb8vJGxhMiweuozcJ9xYMdMxWB7Ik7JPiythsnE31KylqofthQHKvGcnmV8nTEfk2lpqbREvz/38LQ5hvKD4nXDl57Fz4zbzqA3hGDOMCBYIiOAV6ltcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=caB/dvEL; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="caB/dvEL"
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id Re6BsVmKZ1zuHRghRsHudT; Wed, 10 Jul 2024 23:26:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id RghQsTUYQV2ivRghRsGoGW; Wed, 10 Jul 2024 23:26:13 +0000
X-Authority-Analysis: v=2.4 cv=OLns3jaB c=1 sm=1 tr=0 ts=668f1895
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=QdaU3yBqoJsCgmx-8bwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fAOAkXV81GJSC1GjllVIjMD6JIIEOVrg4bHKVpSfYVc=; b=caB/dvEL+y+mrfzuPdAJU0c5+M
	rBis592lSUrxor4iU69dZb7v1oqUE2bJ4E+5y4kCzEcAGVvFLPh3zObKd5spN9Nlb8Y2et76fj02v
	gKFCZEnyPOEUlaL6Xz6b9dv5cwLNJcWKMOtkGfCeBVVk4S9IrlUCc0cf5PO7QQcH/+WomULuW9ZMu
	+ALrnZM5EdQMiCCZiL+lWul+DWEeSdqh0aRmgLhqc23yT64vE03xTHmxK42lyhrlFa3fVNACI1Cqo
	g7bkK2y1Uivuz9cOUU99oZujHlMJm3xPm4Pf4CLyVwRvNRmsWj6RPr78wRc7pgKrpfZKk0nyW2bGk
	S9rn1ZCA==;
Received: from [201.172.173.139] (port=58644 helo=[192.168.15.4])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sRghQ-004MkP-1K;
	Wed, 10 Jul 2024 18:26:12 -0500
Message-ID: <1f3ad235-b2c7-47e8-bf70-b910d397d690@embeddedor.com>
Date: Wed, 10 Jul 2024 17:26:11 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/affs: struct affs_head: Replace 1-element array with
 flexible array
To: Kees Cook <kees@kernel.org>, David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240710225709.work.175-kees@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240710225709.work.175-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sRghQ-004MkP-1K
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.4]) [201.172.173.139]:58644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 38
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHpkUOgoTHV8+Bm79yXIqLAQaEBZkri3tTKVGL1Pyd8caEL+l0SnqPfpmkwKmrcNqiosp4+qB+b0W83Qr7N1aR/76hy/GYmsAP7ySPdo2vlcQRYA/lOq
 G5ScQJb5sXroRo0o41RG+drlp+LPOe80t65Uy1SuIPXf2ksfnkOjTDl7Dgyn1Wxh7B8j8ImL9ReFsFG1CTqhS7izCSOQu6Iws/dxWNYc3kR1CZONUftOU/ds



On 10/07/24 16:57, Kees Cook wrote:
> AFFS uses struct affs_head's "table" array as a flexible array. Switch
> this to a proper flexible array[1]. There are no sizeof() uses; struct
> affs_head is only ever uses via direct casts. No binary output
> differences were found after this change.
> 
> Link: https://github.com/KSPP/linux/issues/79 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/affs/amigaffs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
> index 5509fbc98bc0..09dc23a644df 100644
> --- a/fs/affs/amigaffs.h
> +++ b/fs/affs/amigaffs.h
> @@ -80,7 +80,7 @@ struct affs_head {
>   	__be32 spare1;
>   	__be32 first_data;
>   	__be32 checksum;
> -	__be32 table[1];
> +	__be32 table[];
>   };
>   
>   struct affs_tail {
