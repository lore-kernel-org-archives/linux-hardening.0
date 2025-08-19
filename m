Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A1CA6B
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563653; cv=none; b=JoUCMB1wdOhe1+jsZqRW0k86epig68KpWBODvPMrp7EOPMfDGPmly/E7O4vSGGLTztZr1WI6BpaKDfiP96lx5gWq++hO7fin2jWXLlZeAvOcHBz6k5iKsvDPW7Lo6lmX/8hOEvNj7fqn4L+eHquGddiOIFccHgbNSc7cbkA0WzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563653; c=relaxed/simple;
	bh=VIj2YbU5o1RNHaFfyeLVtpSo78+d55miYm5h6O1qnN4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QxWw08w+u1uPIFHsffwO0GASRwBxNV2uhg6lEa0wYcIx3yneqL9N71kGfCU4MzPgv4uwYQRaM43EN3P6rOSYlq87Q+UyefxKeDGP2Bbc40HJNAy8pRluoS4WatuYv6FA0hNLgY+fluct7Ha71MAGvyTjrxV0nqsW1JNTmLRCQ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KxI8Cjev; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KxI8Cjev"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755563646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VIj2YbU5o1RNHaFfyeLVtpSo78+d55miYm5h6O1qnN4=;
	b=KxI8CjevBfsn7Z0BxhF1SbGMKg+RgAwIxiXyAWUW/S1KSGEbLLDNayeWDLdFvYxRLte4+T
	4MngId6ICTspUMQqmzRCZBaw5ksNq7Pe9qczEV24tZ7/8flpgQ8QMseMNqTqLN4Dyrtx7/
	3PpVbxzore0atenB9myOpoqSoB4EDYU=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/8] MIPS: sgi-ip32: Replace deprecated strcpy() in
 plat_mem_setup()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <6d7mznlomgbhqexp64tswbozmlqk7svrek66zggjnhljsdzan3@3f66zsc5jm5y>
Date: Tue, 19 Aug 2025 02:33:53 +0200
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-hardening@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4431470-322B-49C5-B55A-B236C8E04D77@linux.dev>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-2-thorsten.blum@linux.dev>
 <6d7mznlomgbhqexp64tswbozmlqk7svrek66zggjnhljsdzan3@3f66zsc5jm5y>
To: Justin Stitt <justinstitt@google.com>
X-Migadu-Flow: FLOW_OUT

On 19. Aug 2025, at 01:40, Justin Stitt wrote:
> On Sun, Aug 17, 2025 at 08:37:12PM +0200, Thorsten Blum wrote:
>> strcpy() is deprecated; use strscpy() instead.
>>=20
>> Link: https://github.com/KSPP/linux/issues/88
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> arch/mips/sgi-ip32/ip32-setup.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/arch/mips/sgi-ip32/ip32-setup.c =
b/arch/mips/sgi-ip32/ip32-setup.c
>> index aeb0805aae57..c2ebc4bbd866 100644
>> --- a/arch/mips/sgi-ip32/ip32-setup.c
>> +++ b/arch/mips/sgi-ip32/ip32-setup.c
>> @@ -14,6 +14,7 @@
>> #include <linux/interrupt.h>
>> #include <linux/param.h>
>> #include <linux/sched.h>
>> +#include <linux/string.h>
>=20
> This new include isn't strictly necessary as it was building with
> strcpy() fine before?

It's not strictly necessary, but since I was often asked to explicitly
include it, I made it a habit.

Best,
Thorsten

