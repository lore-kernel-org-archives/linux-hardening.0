Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE028101C4
	for <linux-hardening@vger.kernel.org>; Wed, 16 Oct 2024 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729041792; cv=none; b=Xz8panaM7nN5LBxZMVYAaDxWu9Lj2ud7JHYThULZYg3WNJXbNCwuCilC0qNKZPXxuBtAvQJnh2O5KnJg4+bHZ7PsoPG4Z+zQsELiXDKfEhXT83MNOlN81H7L2dLbJA2a5GZz1QzEjAGLSJ4J263nJihuK/jvH2fXfPFRFZ378eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729041792; c=relaxed/simple;
	bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Txuxy3JXTv8qEI6f2/2VcELHqX/Q9yAUsLdCErN3YQ+FU48Pw7hFuox9uh0vXFGf+HoDd2mU/ArURUHY3vkTToUt4xl6xiRfBkSOEqXDgYyFSiLlmueeskkTr4wqi5shbcQHT7G6nWRZbO4S2gdhroxDr4vrc/rxBNenApLQ4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSFTIpZb; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSFTIpZb"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so572735366b.0
        for <linux-hardening@vger.kernel.org>; Tue, 15 Oct 2024 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729041788; x=1729646588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
        b=MSFTIpZb2HNKhOW7IY+Mal7DtWGSFphZFEbUqc8O1ALbn6XUbKAmQrLfKAoJJJZXcR
         HHjkfXpHK1dW75rtDd8OPNZO6kWdq8pDpzk0Yu3GXFly7jt/9XofjP6p5amIgYacnGsr
         OYN/egF9ZoFKOXijHxyDIOw29I637Bmi14/UjGb1YpKNhbrjiP24/NGkU54xqSZ9w+ai
         hS050iPK5X3ecAhWmeJJBjMRo5AG4McD/4et3ITfOFlwYsfajoNf9Z5A0cOBdI/JzM0x
         bgG7Yfn37NkMEv4OTyZCuPOuLjyxh23sUJKFfqOpAo8yxkmCMP5nQ+bEOJyM0h4FvzT1
         X7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729041788; x=1729646588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKMOa2lsMcZ+PzeFhDC9/s5MDDTvDylmgOWrFIZX/mc=;
        b=cxvGOiQo5OWZgIXXruH7JOiLygSkC7yBged2lhzPG3oeJwGmVvCsSvj40Y+y/kwtOR
         qwxPFE+sd3T/6xThY/o/1kvshAHF4gxEgeXoZnJYOiBywFlblbKkr9Q892R7g0d2XOnF
         hJTOs1NXe3AasxljYTYFA0eU/mVCdQ2qgqjKtDENfw7itsayxDgBgFQKLpppgbvWRJxh
         KIbPHD0PCuFX/drwruSytNw/OAzxQxRsoRplm3RYld9BkBwcN6P30J5ZGn9FTUo4xvaR
         BGrQqCnRH+FczQqwyPv57eiHRa3iO4OXKlPMgm6JARHKF6vCuRxcjnliYMdhu9tEd67b
         VTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWou1IpBarQnpu9YhnndP0IOeB9VMsuCd09VNDLbEjHsDfmCyJHfpnf5xV5MBdXKv4y2p70knJO04DlGEHO8ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuGqnDISIak9GVcWlrNvwcibnhW+pMpxJLaKAJWK7YvNK48/A
	tZvKPy0I3zNKRJ3RDyPnT7pi0c0+PteM1hOMWwoiACp3Cf8RzviwIa1ZHliOobskqMJyuBRn/2U
	nHxxVdvoyMrVUNYFEy4gxoNjn4X4qQnfVXoM=
X-Google-Smtp-Source: AGHT+IHdkfklJ4F1OwuM1/1DqBmbkhdk3WE3vsIugWlT33b5VzThcJq7LfO9xnbbLXiMKZS361OAmCHXw1jqbZb5Hjo=
X-Received: by 2002:a17:907:9709:b0:a9a:4d1:460 with SMTP id
 a640c23a62f3a-a9a04d10662mr910288566b.63.1729041788043; Tue, 15 Oct 2024
 18:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZvV6X5FPBBW7CO1f@archlinux> <3E304FB2-799D-478F-889A-CDFC1A52DCD8@toblux.com>
 <A499F119-5F0C-43FC-9058-7AB92057F9B3@toblux.com> <Zvg-mDsvvOueGpzs@archlinux>
 <202409281331.1F04259@keescook> <21D2A2BB-F442-480D-8B66-229E8C4A63D3@toblux.com>
 <Zv6BEO-1Y0oJ3krr@archlinux>
In-Reply-To: <Zv6BEO-1Y0oJ3krr@archlinux>
From: Bill Wendling <morbo@google.com>
Date: Tue, 15 Oct 2024 18:22:50 -0700
Message-ID: <CAGG=3QVecaZfoRrjToToq8=Azh8M0vQ5Q=V8dfhdBnDR8GWy5A@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] erroneous buffer overflow detected in bch2_xattr_validate
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, Kees Cook <kees@kernel.org>, kent.overstreet@linux.dev, 
	regressions@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ardb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 4:33=E2=80=AFAM Jan Hendrik Farr <kernel@jfarr.cc> w=
rote:
> On 02 11:18:57, Thorsten Blum wrote:
> > On 28. Sep 2024, at 22:34, Kees Cook <kees@kernel.org> wrote:
> > > [...]
> > >
> > > Sorry, I've been out of commission with covid. Globally disabling thi=
s
> > > macro for clang is not the right solution (way too big a hammer).
> > >
> > > Until Bill has a fix, we can revert commit
> > > 86e92eeeb23741a072fe7532db663250ff2e726a, as the problem is limited t=
o
> > > certain situations where 'counted_by' is in use.
> >
> > I already encountered two other related __counted_by() issues [1][2]
> > that are now being reverted. Would it be an option to disable it
> > globally, but only for Clang < v19 (where it looks like it'll be fixed)=
?
> >
> > Otherwise adding __counted_by() might be a slippery slope for a long
> > time and the edge cases don't seem to be that rare anymore.
> >
> > Thanks,
> > Thorsten
> >
> > [1] https://lore.kernel.org/all/20240909162725.1805-2-thorsten.blum@tob=
lux.com/
> > [2] https://lore.kernel.org/all/20240923213809.235128-2-thorsten.blum@l=
inux.dev/
>
> This issue is now fixed on the llvm main branch:
> https://github.com/llvm/llvm-project/commit/882457a2eedbe6d53161b2f78fcf7=
69fc9a93e8a
>
> So presumably this will go into 19.1.2, not sure what this means for
> distros that ship clang 18. Will they have to be notified to backport
> this?
>
FYI, Clang 19.1.2 shipped with your fix in it.

-bw
