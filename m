Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AA5199385
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 00:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774916330; cv=pass; b=WJ+MKWsReA7Zv7Spt3+56B900F2igaB5zuRNIXNx3ZwQPAVclrJOt3lsRCUrFRFfnSfQo98RvmusMKnJGC60HUWfRrsR0Yo2bzAiyS6dVVkGdu+EbTRGx9BviBy3UEjGvJvMOX8p5+LrcO4CtwnSa9TD6zeBISdodqxzniiyHWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774916330; c=relaxed/simple;
	bh=7RaN9qNmZD8w81PNEK6wj4TA72Y+HDMEXcjQqjMp2ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lALAfLPIaxdRpbz3c3Sll1zw9uc5gQOe8Z5UjnjvZkkSRLVMPTCaoOZ2uf+6gNnLpuSECRm5uBB23ztOjUkhDUO3Zo8bu3MeXJ3tbAJEWZvHbtYeYAF2gAn1Nc5/Hz7XephbN603Y8fbcVvAvor6jaOt8in3zLuNq2vNv1fVIFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXe0fOmo; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXe0fOmo"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so6072747a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 17:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774916328; cv=none;
        d=google.com; s=arc-20240605;
        b=FNl5JRg7/iN0HMd2FQTSS12WFjPDJwZr1vlFvEuNb8PESI+qngU2Cf9p9WrIN4+Wv8
         +jCcqUTLP80nXT1hAfaC9ufERUvVKNwVDd2uEy8yoHL7e4+pI/BkBbR7R4385GOpHx4I
         pb01H3wlQgapCRYR6jav7hXm31sJo3vERIKnLloMKQGytt6cG8p83yeZmvbb+6zkGomS
         LF7eRezglQ9NGpu/MBRB0YAbKyLGZAC7gHjcFL/f4AcI0Pt6HPL6mAs9+/bMlGS+d3PM
         kLJKzgh9P5xyvyobtay+Re73X3JfCI5al2PVJtctlwe4wEHFUpcoUaXWM40EZTbE0e9A
         U8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        fh=csmb3f/y6fLEOVVl43r53dPwASncRHTST/ysb/rciNk=;
        b=DHRw5NTXpQpxvu2yyJFy13/wH2TV4djYTVbINBDO6Dk/NoyIytGmpTQyAjP2e+ihky
         QPZ98u/wvBWiH14iLC6nD1sniNJM5ZQBHAkjKlnz1ltwf+4OzP8Ok9ftZs4dg1XprLvE
         xiZWFapgSioO+TKcLKiE4n935lXb+xVekb7D21BE7J8cJnC1hKgdXZfJoR66bLnG8NLw
         +idve4Q9DCvJbV/GkDTOwLKfdJFZpYvcQkF0aIHVcwPckIAS3aWeBwx3OsHHQ9ZM1OPD
         7Kmkj8VGbPE8LVxMLDuLZVq/zOhF7VspVjw/xXXemrFAbnO5PP0yNagiAx811x7IaZcA
         pTmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774916328; x=1775521128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        b=fXe0fOmoIxuH7EOmbAZKwUtsvdWBFUfjGnWRvFdnqMuxWm+Yoke0OBLQu+8prcwqiU
         TqN3lAcG8t5hL6xV4CBOso912yfgpcg3GV8OUgijBucgh1xUTLOh/n9Jtbk2ofsg32Pr
         EEIEycGQlOt/f/I0LNfg5JlxvK1FNpdhduQ9lbcAz1dRdkEXznc9hIpMUIr0nPonbSvQ
         OuoKbnflwEaL5rN44BkLdebFyI7AaNDkiO0mIjoXO8IyWOhGyVXsMSy9jhUlGDD3D+Y8
         pr9KE2njWm5X4qiUG9HdDFkRU2kR+cyFdWhBRWzUhUmXkNLQ69mg/1PNBACvZn+v9W8y
         bQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774916328; x=1775521128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NPx0UKhp6L9irwnUG6E0gP3VYCDhzREJ2tJuZubyGeg=;
        b=nd+Ts6hOoRhIGaqwGWUv+SSV5Wyi+1RsM4GsBfaUjANjvnf64FMufF6JarLAgAnSa8
         uynrN3CthBI39V/xaJ6Gx8OqxTCMiWx8UarIv/xXyCnUYRYaUq7fDq0hlLH21fzdte46
         vFUlvPCKEvNvCJItOcmXODoL6T5yJzRDhyLCAw+ZFe6DlhJ6l7zIGC/SBzdii+ZTrNmh
         g+R0qOSpCilBz8F4FKoJtRz6F4oRwnBYDm6rIaZTXDGVFpgCyu3d56y5ACjyt12g5uhp
         fYUyEOJzVnJq/4rKuGdk3Dm7CoRw0WNF3sHb3S3ChAluDg84pSaiG0e1/UsBXNVLyLMz
         rDYA==
X-Forwarded-Encrypted: i=1; AJvYcCXc0SSsbdD6t4jmryRrHBF5C1rHX9I/B2c4GZNY+PUZR+QmNd8eLM9cYIZqFzENl4QYDSUviRXIRZBNOlIxNyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoGwR9WwIR+B+PhIGuoPKCXUaaPL4Gfm1VpUwP+EKGpsEg6Qr5
	h+k6j4Jn/URwo+V/CVooK+xAN2/AkHngjtBV17v6yKeuef4mM3OX0phj7zgAEiCrtBRXMHP81RN
	QQPHtY98SaQbZ1ejfoZlWv+FT3iqfKkw=
X-Gm-Gg: ATEYQzwWltnDPjWWCpCa0GX7f68ry9pO737kbGpAWEnHh/9Va1ox02JtYvylckVdo9+
	g22N6mySZPYZ/s2PxtFpE0QcbqH9z7KSrxNprUteQHWAlIfJyjvJPXvWVRdeSzjTk76YIjYCWjK
	4Rmp/XgzaftuZCtpoED0i9xt532hbh1NUZrrgp4eCN8oIJstHu746gH35VQJMSUAfXgRvPdH37g
	sZsl3pDETR7xJrMYTZJh5Wr8jmnaf5T/ogME1fAXC+NYK3wGdRxDEAz6n90swvfGQdNNLD/+XbA
	22CTLHc1HvVrM80bTrAEjqNZX23FNXjS9ekwfi00gcljXIKj0bBAKKSr+tXXwkzID5s2M76JIDc
	JnZy/Rw==
X-Received: by 2002:a05:6402:254b:b0:66c:3447:5b9c with SMTP id
 4fb4d7f45d1cf-66c34475c4bmr725787a12.7.1774916327803; Mon, 30 Mar 2026
 17:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326023747.54485-1-rosenp@gmail.com> <20260330161933.6471d473@shazbot.org>
 <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com> <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
In-Reply-To: <37378f49-437f-438b-ad6c-d60480feb306@embeddedor.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 17:18:35 -0700
X-Gm-Features: AQROBzBKRQYSFXx9_6h0avqLn1ZFhu4Xxz9aDa6KCEykyNNN8CWHNZ4gO0PhEXI
Message-ID: <CAKxU2N_o=x=wSjiQqyB68VvhxP_ZoGoSyQagKm=0BdKkgrmPnw@mail.gmail.com>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:47=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 3/30/26 17:24, Rosen Penev wrote:
> > On Mon, Mar 30, 2026 at 4:16=E2=80=AFPM Alex Williamson <alex@shazbot.o=
rg> wrote:
> >>
> >> [Cc +Leon]
> >>
> >> On Wed, 25 Mar 2026 19:37:47 -0700
> >> Rosen Penev <rosenp@gmail.com> wrote:
> >>
> >>> Simplify allocation by using a flexible array member and kzalloc_flex=
.
> >>> Less memory management needed.
> >>>
> >>> Use __counted_by for extra runtime analysis. Move assignment to after
> >>> allocation as required by __counted_by.
> >>
> >> I don't understand this statement, nr_ranges was previously set after
> >> the allocation of phys_vec.  The only reordering was relative to
> >> setting vdev, but that appears arbitrary.
> > Yes that one. My understanding is __counted_by mandates immediate
> > assignment after allocation. Otherwise UBSAN complains.
>
> Not true. However, it's best practice.
>
> The requirement is that the _counter_ must be initialized before
> the first reference to the flexible-array member.
OTOH kzalloc_flex automatically sets it for GCC15 and above. Useful to
keep it right after for an eventual coccinelle script...
>
> -Gustavo
