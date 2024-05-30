Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222212E6D;
	Thu, 30 May 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087625; cv=none; b=jm/bJB1pCRlTdx1gHboF/NdLptB2SqrtEvIoUbH65aADPpXsndflOAx8WXtaweOCJk4i5ISzwSRgz1kB+P9sgRAstU3pIkOeIdXEXj1ROdlVPDA96ZuLICCNI+fgGeaYPe9/fWjTtHaA9FVsYNTryXScgV8NFpxMP55AF9U5nN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087625; c=relaxed/simple;
	bh=tu5BfUUBc30BLBUzVrp9b6Xi5nxO17CyLvZGzIbmMGE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g5nEq4Dh0aHGhs2l/k0PPELSqRNPw9eBp+qp3BMKjh+psn0ZXV6RSrxihS5XjuFad7dLGEBCA13ndMxJ/vmfoDut8grr7liCmRSbFyNsAbbL4Fn8gBeMevT+hXi2E5MTzbgJAQhI2wMEMKnrlGJvKYTggtqM0iMXTKdBBxfgd+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RhrC0ofV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RhrC0ofV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CFBA740E019B;
	Thu, 30 May 2024 16:46:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TCuf2bHIsw_9; Thu, 30 May 2024 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717087614; bh=RIE8A6E1KgHX+2udCSMXQi2ZYnPIEXKt4Ri2S2VuaKs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RhrC0ofV8YSQHAmGr8+Kguq/kJQmREmz9cnAz8rI6zbPBKte7Rc2SaCajqTqs9gQs
	 M/0r62Eo1wuwHlYF5wP+177IrVUjGmdcx1mqaORrEtGRYGYVMcyVj8rz9TbyyRe3vA
	 8Y/jtxA/+p8lE6BC0BTm4pL9JgUpStXvfjvdrHxYPfu/W7hChTpvc23FXXVexv/adq
	 OLcXaSdZOctUssZ8GtLrGsVUkej/JQhgt55x32H+TMJRhYguqmE6BYMkiLgOWjlml1
	 63Hnk+EECSu0XtDGcZNXFfn0/p2s/4XbO4xent8Pw9blFtssLk73qnl0n4q5vKR5Hr
	 +tSzfwa8aQx1U8qMA46v3do309WRMCZKpTCMOO+vTlIo5mgQu2HMldlTh3SsPnwzDo
	 dwgzexQ0oSysjBmik0Le4wIya03hvWJGvpiJAWBoZzasTQvt8DCqq1C96t3euB+SJg
	 AWOP4hXu09lQ6Me+IGYOH9nf94JR0iFjE5MW92Of80P8bMg4ZmiN1wG6shDQdNlycT
	 U2tvF4UmvTLDANQrvNPGvBZE7jS9IJx57NiU/5skcitq24M5JytlHOUeyrPMJYX0LE
	 3ZcCfZd9yswza//T6TPEtipJBz+PallKxn2GMNNVjHq/Mq3xnCzD8LjL6B4gm0WABx
	 554+NjvbdMUd05fFZ4kIqE94=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:20f:938d:41e9:261d:4ad2:487c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADAE940E0177;
	Thu, 30 May 2024 16:46:42 +0000 (UTC)
Date: Thu, 30 May 2024 18:46:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Kees Cook <keescook@chromium.org>,
 "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
User-Agent: K-9 Mail for Android
In-Reply-To: <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com> <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com> <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
Message-ID: <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 30, 2024 6:23:36 PM GMT+02:00, Jeff Johnson <quic_jjohnson@quicinc=
=2Ecom> wrote:
>On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
>>=20
>>=20
>> On 29=2E05=2E24 =D0=B3=2E 21:09 =D1=87=2E, Jeff Johnson wrote:
>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>>> 'make W=3D1 C=3D1' warning:
>>>
>>> arch/x86/boot/compressed/misc=2Ec:535:6: warning: symbol '__fortify_pa=
nic' was not declared=2E Should it be static?
>>=20
>> Actually doesn't it make sense to have this defined under =2E=2E/string=
=2Eh ?=20
>> Actually given that we don't have any string fortification under the=20
>> boot/  why have the fortify _* functions at all ?
>
>I'll let Kees answer these questions since I just took guidance from him =
:)

The more important question is how does the decompressor build even know o=
f this symbol? And then make it forget it again instead of adding silly pro=
totypes=2E=2E=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 
