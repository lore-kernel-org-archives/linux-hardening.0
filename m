Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3733D648F
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371997; cv=none; b=g1FzMU4HA8mRobx1eLgHvPHy8TrZoVMr3N7U4/HwG1UyyjCgZgIXcmEiTWkVeBOTYic4D27A8Fv5zeoSfrwHeD/EMa70V+Ax0D/QsP3QkCUhRT7iMWX5z+dk3YdaiME0yJDIg2pikDM+5FjWsRbl84u1ryC2uHD0fdIJw8KYAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371997; c=relaxed/simple;
	bh=Q1iSp05Y/GM79eVG3nz7d1/FrmFsX5eWbL5dWFDrKic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh/9VoXpUD1Y9nyfUNCphNvI8gpXc/dQX6MszCI5JZX4w5O3Z+8DHvBQnTX07gpfQXT8+ci7voLlbrrG60p0mIViPo7I92FlzQDhSShq74cqnO5hQaYWkni/y4RAbf+VwrgfH+zeIS6LAn+ynkRzEHHwt6PsmJKFMSj0XOfwCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdkdgpvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdkdgpvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCAE1F008A7
	for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2026 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791371961;
	bh=Q1iSp05Y/GM79eVG3nz7d1/FrmFsX5eWbL5dWFDrKic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CdkdgpvnWXrleEzlQfwdm2ccr+r1xMfSUAdQPfHJBe5EkXHVzIOORqtLHsmTz5Yzo
	 dERGTZ6yQGP3aG189XNfkT+NYTKfKKKuOdiO6bx8RLehuHmBDFSGfwiBCHitcwSTYR
	 GKHBYc6a/xNn+l8PcVFsDbIC/iy0/mp51IXltlZnxh6dvHyoU5t8CWtvmCyBfOcjKf
	 0bY8PzPk7Y7IH9aB5SRyaGPW9jrr+R7KJ9qRdHuCbVlJWzMG0KJ+m/tMXUCi+XrAAv
	 tu2uryM6rL7OckmvqnQhQ3bfwLJHdYhJjKGGw9foKbhYSLanqWaXKU5clI55eoei5S
	 aNtEARcOh3Afw==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aa9606ddadso2701883eaf.0
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2026 04:19:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxVcYl4UPbfPM1NLxtn/5GEj2jAyLrWuKXGcUkZ2GTDjmLb5GI5odPsGvwd6FGFtN5kckFo94ZNB4mvCCoApsg=@vger.kernel.org
X-Gm-Message-State: AFuF++mVAl2gMrctQUmPBAGaMU8TKTr5OhAeQEAQMFL2EtKmDNJ6nlUq
	W2wYTe+pdftcYD/sJNwqhWSxzY8asrTgoDDqCsxF3exSJuiKTN8yQPKLlfywj16XR5BmzWotqJr
	RPhL8DBdx3XfrxRCvBmqZTyyvo4wzLsE=
X-Received: by 2002:a05:6820:2d07:b0:6d3:402e:1fc4 with SMTP id
 006d021491bc7-6e7a6e60903mr2071504eaf.48.1791371960255; Wed, 07 Oct 2026
 04:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928063824.1386524-1-morbo@google.com> <CAGG=3QWCmQ+LVvn2dtjEauj5WFwvx=pvg4Q6man_A2imdjRe7A@mail.gmail.com>
 <CAD++jLk2pFCpbpGVCQg2AdrwQecpb=wsehhwSuwTbKAXNeyfoQ@mail.gmail.com>
 <CAGG=3QV2k-nsZHNSuKEixZb+-LcxvhQsG379ghgyOpiDLTJWzw@mail.gmail.com>
 <asNuMzqz3G-gmIiD@google.com> <CAGG=3QV1eLy-eAfi3Q49qwMw_Yw-BJ1tmd3J=SLJB_qWrx4bNg@mail.gmail.com>
In-Reply-To: <CAGG=3QV1eLy-eAfi3Q49qwMw_Yw-BJ1tmd3J=SLJB_qWrx4bNg@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 7 Oct 2026 13:19:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLmR3hmEYN+-YCAcNq_0Zk0=PijS9jhGaMppkNhvbs90JQ@mail.gmail.com>
X-Gm-Features: AclHuK8-ODudQDmu_mYfAfdHUSYSOXtS3Zd0jQ7M0p6lH8u25CuCRiFtUDTCe7k
Message-ID: <CAD++jLmR3hmEYN+-YCAcNq_0Zk0=PijS9jhGaMppkNhvbs90JQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: annotate struct acpi_gpio_mapping with __counted_by_ptr
To: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>, Bartosz Golaszewski <brgl@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:26=E2=80=AFPM Bill Wendling <morbo@google.com> wr=
ote:

> I sent a patch to add `__NO_COUNTED_BY` AND `__NO_COUNTED_BY_PTR`
> macros to prevent this. They're similar to `__NO_FORTIFY`.
>
> https://lore.kernel.org/all/20261005102518.2400984-1-morbo@google.com/

I see you are hashing this out with the right people, thanks for
going the extra mile and fixing this properly!

Yours,
Linus Walleij
