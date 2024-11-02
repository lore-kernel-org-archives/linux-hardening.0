Received: from e2i702.smtp2go.com (e2i702.smtp2go.com [103.2.142.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B215539A
	for <linux-hardening@vger.kernel.org>; Sat,  2 Nov 2024 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.142.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730581728; cv=none; b=THyF4I64PIn93HO+xM3iXLPxcbPXUPdhE3bx4w91n4+bKfXCN4Q538zS0x4GA2rIMjCcXN2JZjkG028HQHoswB76xQfK5ghyt6LpS0XCNU9/iS3emN7U1hKoo0ZSFCFijIKxnhJhxtRMFNdiJRX7md1ziacjGwCPVYbfWWukGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730581728; c=relaxed/simple;
	bh=HMMX2lwn+yWZONXGGimkqS5HF8zoQ+40TkCJJptfbKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDKGJx3kI2AyjtQImvmYZghGBglp5S/B1TwSfQU3QSSj7yE+0K3rZkviCdsDO2NdosBAr9Tl8LAX8JRtDxcu0lzRpcU/l49Tzoe1L8Jd5QcaLBLncxsbN4XOVZdURAemXC1Zy7p2/uXwSMmR0kQ47JKCk9AwuJzj0BFTZ1r1lW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=em1174286.fjasle.eu; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=DfOIkrJg reason="unknown key version"; dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=JWpWnL+X; dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b=U1/gfyC9; arc=none smtp.client-ip=103.2.142.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174286.fjasle.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="DfOIkrJg";
	dkim=pass (2048-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="JWpWnL+X";
	dkim=pass (1024-bit key) header.d=fjasle.eu header.i=@fjasle.eu header.b="U1/gfyC9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=mp6320.a1-4.dyn; x=1730582624; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=Nj67AeiaPQEBqiINOFKnae9vYS4HDribcl5S/Fxqsqc=; b=DfOIkrJgTL6y29O9dCarAFB8o7
	Y0ERFSfF1MPUEn479IOSu9Uta/gPg5qB2VfYUJTvzMN1boeQQOukvOV9tCFPXlydYcCGFRAzl8OLR
	fn8vW9EViitD3JOWZ3COddlYJlZMm21JZ5l44XhSRfI0LmGnP/gJ7UHdrLSBUjPOjYVeNfAwRuVA+
	5eGiaKiUEkSgtl0BuXL2L6fx7aRYIp2hjGp3lJ/m5Z6elndSh367cUQYUaDxvo5DIWmcnRBOG1BI4
	FA9RTaTku/gsxiV4Gb2JKgerodsLBDPmBIkCAIrkdgg1nlUE+1acea6B8FLTHSmywJ0BpwKoiVGu7
	DYQxOqfA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjasle.eu;
 i=@fjasle.eu; q=dns/txt; s=s1174286; t=1730581724; h=from : subject :
 to : message-id : date;
 bh=Nj67AeiaPQEBqiINOFKnae9vYS4HDribcl5S/Fxqsqc=;
 b=JWpWnL+XsuzxhPgD3rJGDIU+2/3Py6XVsrMUv8cvsYutO1oQuAKOYOxKvcK4XMU0vt5QG
 g5fCzj2wVieR9I7wyKv7mBSNx/TJwVRcFmG0KkJ02CPbof2lm4zpqUhzpAZ1PHbeBc9HhBd
 RXJX24J2rU2hDmCykRgfXO9B8ufktzw7vL+ntjhaNfKdwIVsGjThIlE2NmBe3Xh2/s6M8Vc
 XFgvHVj1iSQ14bsSOzIWduvNpdpJiHx3juC9DuDVLJVaCHQhBfthtB3D3xfs8LqSCMhjAFC
 8tFvXw3ogsLbQ65miM4Y+cOzRWuyI0qenFhgsLMyj6505rjxQZqNp3S4rmPQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LLi-qt4Dxk-5t; Sat, 02 Nov 2024 21:07:58 +0000
Received: from [10.85.249.164] (helo=leknes.fjasle.eu)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <nicolas@fjasle.eu>)
 id 1t7LLh-4o5NDgrgQ6c-mrPt; Sat, 02 Nov 2024 21:07:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
 t=1730581677; bh=HMMX2lwn+yWZONXGGimkqS5HF8zoQ+40TkCJJptfbKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U1/gfyC9by+/nynTWwEi4kx+/FUmZVdzL0mM9vPznDEFHG9btvCjh6ZL+yrs2Tqks
 0l6d3Dt2szx2MQIpiKFDqgAcvP6wgWvFiRXYa+1peOb3LH+lD9nLqozP7OOcNyhLXX
 lHtoZw+RWntJDZWwiN0qqYSFeoOvYHMVuvOqCiX8=
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
 id 095B73D7A0; Sat,  2 Nov 2024 22:07:57 +0100 (CET)
Date: Sat, 2 Nov 2024 22:07:56 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Morten Linderud <morten@linderud.pw>,
 Haelwenn Monnier <contact@lanodan.eu>, Jann Horn <jannh@google.com>,
 Kees Cook <kees@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Theodore Ts'o <tytso@mit.edu>, linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] kbuild: pass KERNELVERSION and LOCALVERSION
 explicitly to setlocalversion
Message-ID: <ZyaUrD6XC7PcPTSz@fjasle.eu>
References: <20240819160309.2218114-1-vegard.nossum@oracle.com>
 <20240819160309.2218114-4-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819160309.2218114-4-vegard.nossum@oracle.com>
X-IMAPbase: 1553198760 0000000191 Old
X-UID: 187
X-Smtpcorp-Track: cfOVxBVj2wBX.oc5cZRpKfdN3.gyEKQwn0KRB
Feedback-ID: 1174286m:1174286a9YXZ7r:1174286s-mEjfdzIe
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

On Mon, Aug 19, 2024 at 06:03:00PM +0200 Vegard Nossum wrote:
> These environment variables are passed when invoking 'make', but if
> running 'make -n' we need to pass them explicitly so they become part
> of the printed command.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
