Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CF449ECA
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571090; cv=none; b=TPe/5qrtfZGmclSLT6Wua7HLihLeYyrA0NpdwTWvzJPskkPiEqPVK+Oweu/818ZO+koxc+ttVz2rESwxivrMx/Fyo7aNGhHGHLb68Lrl2CLP2v3CK62Kte9dBcLUzUyroQzf9Z0IE2rjWNyv+GVk90PzXPO7qQCbce5IxWwur/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571090; c=relaxed/simple;
	bh=GHRSqlUETSp8BScDc8UzS8c4UvPdttzofOIr1ef2KhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6LO5k1AjXUJ8aqugsaLm3nbXncGigGnmwhtUFFd39tIxvnQFLqLLOc02zInnUxuNo4MbC/7VszLxaT15NpJwNKK2xNzEiwjbH6WGVkQYKGE0Bujq4S8Xss80y6ZWBvWP/Ysfv4KySffJl140QlqTO10wCsDSD3ubk03XA0cQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=QOuqoknL; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="QOuqoknL"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id ITo3w6oVA4RkpIVPrwfrES; Thu, 30 Apr 2026 17:43:11 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id IVPqwQ4rNWrBXIVPqwbOwl; Thu, 30 Apr 2026 17:43:10 +0000
X-Authority-Analysis: v=2.4 cv=ALkt6GG8 c=1 sm=1 tr=0 ts=69f394ae
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=7T7KSl7uo7wA:10 a=c92rfblmAAAA:8
 a=Gzb0PC3O3UAx9o55Kw4A:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j88sOiZjSmpXroFOaEZFgoC5LI9ePIXWW+V4QuPo+D8=; b=QOuqoknLF5DJbJxNPfaGled5ya
	uzes+Xp5COQ+L0AwtciFIZG9VyxWrvhQaBh4nQlsaEpUX9UC/wnbaS8LFQxRGJ4arV3uG+4/eW9iY
	/rcnI25JSEVkui8Z4m/Uy3/yXEdCVIshEDD4fv4As8O3CZPqoWm/ydMQZLePGrj9QfFV3U6tqw/og
	bxWBCk+ptfBBb3jUYuJ85eKMQjBQwwoDQQ6DaYubcN/mp6dYuH9UVtXrSe7r5olLO4ubpDXjfCu6R
	svA2urybXAQdn+8q0C35cL+ONjsfJMne/wTdbWmbjfmznBwy54o+26v5uAFH58OZ5fgvpGjAult4P
	Mk+/aW5A==;
Received: from [177.238.19.10] (port=58586 helo=[192.168.0.37])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.99.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1wIVPp-00000001Ga8-1QtV;
	Thu, 30 Apr 2026 12:43:09 -0500
Message-ID: <d71b0a25-f65c-4781-8806-b4dc9cc9c929@embeddedor.com>
Date: Thu, 30 Apr 2026 11:43:02 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ASoC: soc-topology: Avoid
 -Wflex-array-member-not-at-end warning
To: Mark Brown <broonie@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <afKSFY3qrlSOJ0EJ@kspp> <afLcQBJ4POnSacjV@sirena.co.uk>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <afLcQBJ4POnSacjV@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.19.10
X-Source-L: No
X-Exim-ID: 1wIVPp-00000001Ga8-1QtV
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.37]) [177.238.19.10]:58586
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKBlo1qkJfk6DDG/d0aSLofJrG2LJkgVx8UXIaFeWcijBXJFx5XdrO+lySM5D4emivKbkDcoYJsdqCqb3Y1rlHOJNrPz2W3R9U9MAnmpN/WasE4W6RuX
 FZKX0jCSzQSnfKgueW74de3kFxtmzhDO1kqEODHQLcVmv1EyIe1naCS8N0VbQfwtgvG3qtlR0fKYZ9M3wJTuwIxyBew4iyyXbf9fAkEzhd5/AlEBN/+hRAcx



On 4/29/26 22:36, Mark Brown wrote:
> On Wed, Apr 29, 2026 at 05:19:49PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
> 
>> Use the __TRAILING_OVERLAP() helper to fix the following warning:
>>
>> sound/soc/soc-topology-test.c:136:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Sashiko is complaining about this breaking some of the users:
> 
>     https://sashiko.dev/#/patchset/afKSFY3qrlSOJ0EJ%40kspp
> 
> I don't know enough to tell if that's actually a sensible report or not.

It seems Sashiko is correct here.

I'll rework this patch.

Thanks!
-Gustavo

