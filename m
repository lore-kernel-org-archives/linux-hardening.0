Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCD3451A9;
	Mon,  4 May 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897629; cv=none; b=FfrQTT1Wh0Lbw1Q/e/p3ovfFT86YL9mFVxtHt6R4I2VmvvxcDCajvsZQyF+1wPXsgz4j7GuuC2bGuhwItxoTYi9aamjPETGoQIJNjwd5uuMvES6bL+rVKQnHAcCP9SWSRL68iCUpZABo4TssjizWoUdH+i6fGfuTDYoLMbKVAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897629; c=relaxed/simple;
	bh=4dd097CnrafbvDCotwd65kOuY4LE3XlUIvC8fyltNys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H573RvhzqYzN4K+CzrLl7hdfnVvYl+mnab8OBaLNc+lAHMbGsOXECJc+G7e79Ji7h8hl3HXkqr8iBPWMWjxX0ZsL4MSdKD2OAkE58z/8YrbrQTx091fw8PSi/yIUQ6BsIsabFRomiTpoWBe0LLju+4+2x5QPfC4KHIBm79U/Lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u5FjNnr9; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u5FjNnr9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4g8LVm4885z9v7B;
	Mon,  4 May 2026 14:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777897616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dd097CnrafbvDCotwd65kOuY4LE3XlUIvC8fyltNys=;
	b=u5FjNnr9H5dWQfKm6tE4g3faw679cJ9BET6fSVbpW6wEkzaQ2cb9+tUX+TeICwR92rBBhd
	byX8uF/qz+LAc2opI03Iw47enzoO/f36UfjN1wqbfXr/Jrl4BbBtQRsgujmUXOAqWpzg0n
	EwXBZqdGsUrqudoL0gvhD/MMR+QWrnUXjZBTnRvK8SntMP4yl2oDzWGjRL1AU7XTfU0Rdo
	0aIaVdLEUPcZWUF0xEbAMOjnzJ8gkK2yjcTOK0OlNp0UMRbZf4YYydynvRD/4vZ0fSofAK
	VqeZcjVbIM2l1S5W81Rl7tXKlbjeiRaagdYnsNPfHw564h/NaAdWwwdGDG9a3Q==
Message-ID: <d9845986b6db299315f6e5e2c02b1f030e03ce45.camel@mailbox.org>
Subject: Re: [PATCH] string: use strnlen in strlcat
From: Manuel Ebner <manuelebner@mailbox.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Andrew Morton
	 <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, Andy Shevchenko
	 <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Date: Mon, 04 May 2026 14:26:48 +0200
In-Reply-To: <afW3tJH4XfeX_OXG@ashevche-desk.local>
References: <20260430205050.400822-4-thorsten.blum@linux.dev>
	 <CAHp75Vd10OdNQfhb-hOAapJ4=uhZ+t26vp_WMAoeCska6NCyOA@mail.gmail.com>
	 <afW3tJH4XfeX_OXG@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: wro5564gwcwfrtdshujp1htrp4uaom69
X-MBO-RS-ID: 576db9731e4a54d9e5a

On Sat, 2026-05-02 at 11:37 +0300, Andy Shevchenko wrote:
> On Fri, May 01, 2026 at 11:55:33AM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 30, 2026 at 11:53=E2=80=AFPM Thorsten Blum <thorsten.blum@l=
inux.dev>
> > wrote:
> > >=20
> > > Use strnlen() to limit the destination scan to the provided buffer si=
ze.
> > > Remove the redundant comment.
> >=20
> > Please, do not spend time on amending strlcat(). This function must
> > die. Instead, convert current users to use alternative ways.
>=20
> Note, there is a patch by Kees to address this in partitions framework
> (vast of the users of strlcat() in the kernel). Not sure if it's already
> pending in Linux Next or not yet.
>=20
> I have done a simple one in ACPI recently (in upstream already I believe)=
.
> So, you can use those two examples and continue killing strlcat().

Hi,
i would like to add this to the file Documentation/process/deprecated.rst.
Does right after strlcpy() make sense?

Could you point me to the examples?

Thanks
 Manuel
