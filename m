Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90023368B1;
	Mon, 16 Mar 2026 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679029; cv=pass; b=SLAc8dSkORSBSIkRCD+M0mtevp8qf5Pgl4x02ynAY+8VjgkGuBn1z+jVIG5kvtdZlkkooFoTkfkowIONZ7K60OKLhiBd0KW3IOtcnuawGJm/wSLvEU4FfxogjBBHOfkToxsW664ByXdYxTx66AJg2zLZyjQrH7RmXAj8pX7fku8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679029; c=relaxed/simple;
	bh=6KFn0Zar/JbiHiv8GC8nJsXyPOlvN3Dv9rlBESOlECE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=mash3qAiDAsXn0UYA3RtxR0/h0/jda5fz4AjpRersKt01UmMaoo+3gsMFy2H6243x1tzlPpxBVfv4yEzXhIEudERGfPvPJwlEjI1ZVMS0qBNgWdzB8D2kI8qzOC+cZibKLKsh6PlJgDq+udpYQgLMYDoyvXCvDuXidMKQJ7mciQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=BkSYOaPj; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="BkSYOaPj"
ARC-Seal: i=1; a=rsa-sha256; t=1773679002; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bF0g7qxU4vLvOgvZJnDT61GDzWws5ezonLBdAa7ynDlUBLG2zJAcYCbtkO9yvlWTD5jbXWN3kAf9gVQfse6IxdWC7ucuvepIig46Niag+3wyqnfbhzxiENyX6+mqjpnNj1RjDhZ5qpozwYmyEg58IKo8Ntqc6cGgpSfyylsmF2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773679002; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6KFn0Zar/JbiHiv8GC8nJsXyPOlvN3Dv9rlBESOlECE=; 
	b=fSnJmiM3uO/0YAyu6xtCQr+8tKBp+XL3LOx6ObURlpw87OKwEJw6Gk7hNJuNmtvAbtWyXfRWMlNtN9yomVOsENqtjCnuk05ZFk7E2k1fBAxhQrf+m993+yRb7Ir7rEOsS3hQPHjQaiHw+t4634obqHCzWNl9vp1l30Dc8awGLn0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773679002;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6KFn0Zar/JbiHiv8GC8nJsXyPOlvN3Dv9rlBESOlECE=;
	b=BkSYOaPjRx0o5bZaTn5ovwjmMy5RKTplV3TIfK3RifswEjrttgcX5vjyoHobz3WV
	f6eKeTBttyqeJT96L+iF5RD8Hht/dynIC0jFs35BIL8ikyM+qKo2ZeQKKCyiGc5yo30
	vMy01HuNTpQ8OdMo2Gzdq6BBrR9vqd1obJZNQymI=
Received: by mx.zoho.eu with SMTPS id 1773678999890716.3968980136679;
	Mon, 16 Mar 2026 17:36:39 +0100 (CET)
Date: Mon, 16 Mar 2026 16:36:40 +0000
From: Josh Law <objecting@objecting.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: kees@kernel.org, akpm@linux-foundation.org, andy@kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/string: replace BUG_ON with WARN_ON_ONCE in strlcat
User-Agent: Thunderbird for Android
In-Reply-To: <abgwF-yT_FtLTgQ3@ashevche-desk.local>
References: <20260316161728.84485-1-objecting@objecting.org> <abgwF-yT_FtLTgQ3@ashevche-desk.local>
Message-ID: <C98872ED-CE72-4201-B5A6-D5AD5EA336CF@objecting.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 16 March 2026 16:30:15 GMT, Andy Shevchenko <andriy=2Eshevchenko@intel=
=2Ecom> wrote:
>On Mon, Mar 16, 2026 at 04:17:28PM +0000, Josh Law wrote:
>> BUG_ON() in a library function is too harsh -- it panics the kernel
>> when a caller passes a dest string whose length already meets or
>> exceeds count=2E This is a caller bug, not a reason to bring down the
>> entire system=2E
>>=20
>> Replace with WARN_ON_ONCE() and a safe early return=2E The return value
>> of count signals truncation to the caller, consistent with strlcat
>> semantics (return >=3D count means the output was truncated)=2E
>>=20
>> This follows the guidance in include/asm-generic/bug=2Eh which
>> explicitly discourages BUG_ON: "Don't use BUG() or BUG_ON() unless
>> there's really no way out=2E"
>
>First of all, this doesn't really change much, especially if one uses
>panic_on_oops=2E
>
>Second, the entire function is kinda deprecated, it's better just to drop=
 it=2E
>
>$ git grep -lw strlcat | wc -l
>142
>
>(In reality it's less as tools and implementation are not users of it)
>
>Third, if the caller is that problematic this may lead to the serious
>(security) issues=2E
>
>Based on that, NAK=2E
>


Hmm, good call, but how would I implement that? BUG_ON seems a bit too har=
sh for a library function=2E

V/R


Josh Law
