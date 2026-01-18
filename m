Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00347234994
	for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768776464; cv=pass; b=fNqHGSnPD6fkp58q6IBwAL392EgE4Ge+z00CDqNfREwfnJWHC9wHFOxfA2fXrcUePX6tIl+eKCQriTESk2kgAoqsHjsT5CWHEFZEb8w8fWE6ym7FoXfcbWrJcfte05mJ8ePIUt26fGB2ms9nVn4DXILTgp2GcVyUMSZsW4aJWgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768776464; c=relaxed/simple;
	bh=ZBpaIs1HHystnXkMKIEfn8j6ZfCRA6e9fwxUVVxwxeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Um2TvWX+pktAvjffRSvJZl762GDb8TKLE0JIc/vsQyaw3LPru3MKYHt/EFht712kWOr+ODbYiQmExRceO+VAp9Wo/yCSSrfhpOfHVtWvImfZ8HKY7yP5eEt1xgKlsgCNo8xDUs0InvazMuxQYbivuTDY3Ki7JBfCHUdjZawqX1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcU1bc9y; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcU1bc9y"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ae5283dae8so234919eec.2
        for <linux-hardening@vger.kernel.org>; Sun, 18 Jan 2026 14:47:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768776462; cv=none;
        d=google.com; s=arc-20240605;
        b=EtxZZjPqmm69K0kva5WJbr4Lq0pAIMwb06RTe+6RXo+0h+0UPr/Vrtn62/xOqu3hhr
         EVuZ3SYNa4R/zBOiTAtqD7AzEX02YXAkpAzqcswW5B8d77NST4LcxWN1TsN0Eo30pzap
         fgQBG2wZv73tuZ3PZwGph6laVjXV9XNPtm0nX98zN3VbQtNyua7Z3KzZ2G1FbPv0ghbL
         fxglN6wRyBagMpMTvwWfC7cg+3l4ernJbd1vEgwpcbrBfM7J9LmMmYBwSFTg99cyKaKU
         gOMxAg+kD5m21IadUHlo6kRooq4PXkTrdII+DTRhjuhNccjbdbYPZaG5e5/MrkM4Ylg7
         npcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBpaIs1HHystnXkMKIEfn8j6ZfCRA6e9fwxUVVxwxeQ=;
        fh=7c7JmT5SGOs8qcgMR4HPspUiW/JU56+YIEcMeqgpL/U=;
        b=klDO4qbtZkT5iLoJTXPQIfOmJp02ggnR122gDn9AeGDiUcPaJIC02lMZLhsuTa8JJy
         8ODBtyEK26aiHImP/1lxMwv3leIhdHYTgOgBjFx5Db6+JY4dxSQeAfgzq6QxSTySi8fe
         B7uq34WdMO5GGXfQ5XitEjv9mYoRCFlu3nqnj79BAWeFwc12G8keY0S0+uxnACGYL0CB
         xy+jVI8dnKublZOKVEeMuUgYWpWbfm2s3dQmYH/TklgphhTt0GRGxp+h6ib8RV+Q0Yhj
         h3iaQT17asA87UQppm4wVrVOD1CITAa1OvGTvm9vu1ltW10sd0GufyeqwI9qVk6jfBEn
         FFCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768776462; x=1769381262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBpaIs1HHystnXkMKIEfn8j6ZfCRA6e9fwxUVVxwxeQ=;
        b=JcU1bc9yLzSAF9cw+PoTE81AfRM8da4lFwqQDFoCrw2XBK/zQOjcL4qo67uHdUq5sk
         /NjtTOYTRzFYZuovWkmvWjBZqF0Axh1/WL53w+stBRAMXjzCGQLI3espVlnMSIfXV2R0
         ER/NubyBJrQFf5oXDI6I65IJCtGv4r+2XBZYuskMf+sVL40uAUwjXaSu4s56z6bkFpoN
         Q66DP8PoRgYb2HjNbzxy2qNTX4VtMd0irqOhnnN3Flr5CyuA0E67LFMD2ed5j6MVZK6A
         0mCg1Hqx92KreKtrlQIFXxnf3eRQa0t4eG63Ol+GjA1pa8W30Ktag1YS7wwYd1n7Enfc
         RiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768776462; x=1769381262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBpaIs1HHystnXkMKIEfn8j6ZfCRA6e9fwxUVVxwxeQ=;
        b=d1qI+ZmyPe9MpmEyriPDQkax4XoaRII+p1fomInkQqLg8h8K6LFigpuw5NBDAP6zxp
         JwMu37UFdeSJq1HzjcQxBFF6jynkIBOfaHxabPbcAyp563xL4aT5lsUMmPGSYeAwAdjL
         sP0pwJdD0voChqKrXweYoykahZm2Rv1rHZmfYrjmgNSsWGX1/rx4atzx4RTI3hvu0hok
         OqckVEv5MuTEAm0iaykgrvH67ReTcyyhKqoGqEz/TotrCD1YtOb4fQnpBgKJYFJ/2WbP
         HE2dx7/v90oAcyAMIQgpOvO1+07PejzmlisIl4lM5Jralo4Uvi/DAsvYocizPfNZa3W9
         zFPA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ejhnNQR/qO5R8fgTvLApN9/HWAq7uPv38c5wGOTysdXSWZ67ocNpDVyxWE8W4Emqs6vZLm33UY59pCv41ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrjjPqu6JjR9H+85fqrUDwxVP8orsJkarNF+lAVif8TQkYKtXX
	tlwmCSQK0XqC6/CTlOYo7ERonSH+hguaDixZXnyGS7MPSG0/5vHpbM2HPLcV93pdXg3v3BW6Fzp
	5621/XKSB+hO+KZEkjmAaMH1Fc3Lad6Y=
X-Gm-Gg: AY/fxX4zm/XiVPbmf5mLbVz3Rwpo7n/dStlSHzg5BbAmV4mbprSZzRzMb/7RHdpAw1k
	fS99KifJhR94g5yDiQujcqghAI7yMlItg/n97QHbI1uDYy4aXks1SCq3zBDvp2lHsukt+aEFaxO
	1xIT/F1QIYtH2U8cZtJ4X353ZhfhKCUUgmLAMivjGok+8FZ/j/pH/4R/bKl9LAFq3ceP+Yg7Yhy
	0DohfEg078qozHFqr81huNB1iCIOGyZ3KrmlzAXOOkvIGg5vRqHbbGXnRWDf4ymjbOjXpMWzu7G
	xh49jP6EFVS1P2xMwj1OhrDDtCF35i6qcsWLQoVcGefT6iqCmesC1xgxFnQ4TBNTZZgagk9aaqH
	S/87jbFXTvNW1
X-Received: by 2002:a05:7300:5712:b0:2ae:5dd5:c178 with SMTP id
 5a478bee46e88-2b6b3ef8367mr4547407eec.2.1768776462060; Sun, 18 Jan 2026
 14:47:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221081659.1742800-1-stijn@linux-ipv6.be> <CANiq72nqwqTmCzKb=rhRhUDg8pju_RB2zzCKnJ5hDrVTUVnhPA@mail.gmail.com>
In-Reply-To: <CANiq72nqwqTmCzKb=rhRhUDg8pju_RB2zzCKnJ5hDrVTUVnhPA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 23:47:29 +0100
X-Gm-Features: AZwV_QimENAu73eyfoDTdWFMk-4fufF1OWMRqN4JWmKaT7_EDgF1MS6gjjBEJlk
Message-ID: <CANiq72kw1Fg3wGOfa7E4tOtf7Ko8BNCZffV+XVgQRqW4PoOfYA@mail.gmail.com>
Subject: Re: [PATCH] rust: bindgen: disable GCC latent entropy plugin
To: stijn@linux-ipv6.be, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Emese Revfy <re.emese@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 11:46=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> change the signature of the functions (and even for variables it just

And by "signature", I should have written "ABI".

Cheers,
Miguel
