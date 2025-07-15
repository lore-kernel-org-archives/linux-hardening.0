Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482926A0EB;
	Tue, 15 Jul 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562406; cv=none; b=XUfr866dwym3C4sRytOE57q6M0He6QQ7x+YXQ4xiw2nJCtYWmXwKHdaZvWOHepzyQKMJ4PASaC/M3BOOojG8s/QVMF+Mi82p+WoPuUh5Z0j/IINrY+oCERYOkvP8qA9MKIFrAWYQx0+ARhuwiv0SPfoKFJiHIstOyItp8r1oRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562406; c=relaxed/simple;
	bh=djB9UmfoDFlQLUFuFBjJAStWc6XiQFvWlampBW+hWcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciu0u+OgdYMkqkTfJaXrECssy9rZMkYyKvSQ7KN1YcriJWu38rTOUFWF9madsG3JR1QfOATZDZ6k2idfpdVerknGw0caRFswQQvu3PyQr7ZIQMvLB9OzQRjI/tul1Go3PvmWhbuPHfGkMzY4IbP73XqZLGrIql9WcySqQy/qyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f33w9uTn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f33w9uTn"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae9be1697easo25488066b.1;
        Mon, 14 Jul 2025 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752562403; x=1753167203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djB9UmfoDFlQLUFuFBjJAStWc6XiQFvWlampBW+hWcc=;
        b=f33w9uTnvU0asW4nTCY7n3zFdVlRv0X1gWBjQN9orPSWVNB1niCSZD8NFN2DjtxCQs
         D5frumiZbpat/hWgJwJ6sXKfvbpx6Nbuz6kvyFaoP8BRDhOlGQpl1s/U1p3i7EhHoR6f
         zPLnpmf3dekbjy/ea48u/oQ3/KQt6fM4pMphETkl5/UbA+x5XImCnbSRFpVjC3QVSfsY
         3l9keu+eYqFc4RLkxlHF82nzwZy6EdlIASHZ827m72tAJxLu/oGjRueIE2F7c8S/CEYj
         O8nW/zyr7CjQ2QujH733qlTosUAxAE181t7J2vKPska9MnGvL+fwCfCPhyK0nWB6gBzq
         trAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752562403; x=1753167203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djB9UmfoDFlQLUFuFBjJAStWc6XiQFvWlampBW+hWcc=;
        b=kwIpgaYuOVcd5iCaTNw6ln+RzLKxTEDUtq8xqPSVClBdqLNcvUY64wFfNaX1gQr/kO
         FOYgbBBGSMD3UZIgw2Mz6CgeuvcF8MeeQvltdsMA9sOXgfG5cTrsI0VZV/HKMwBtfw8/
         3y7kJi9Vyg0kXRFQDE5n58y7Wme4xvdLt+uP/oBXe+2Yld/m6ef7NmVUqcnEgmYGuQpN
         jFPxT1I9rX2o9yrSbgJjmqycPqQCSOJ7N5gQCXKMABwV23WTPqailVZ/Oc0SdJczNLnP
         1xnkWo1E7Rza0hFpvhHfZHeCQXI1x79FH+wDgx/IP3CKYskToiDe9qARfeWA34Ij3ncp
         QlcA==
X-Forwarded-Encrypted: i=1; AJvYcCUFvDS3rEZr4nkPb6pNCge/9rIITTFVBtAw3/xOojCI793cPpxhqP6kXiC5XSj2ABCQxezNUlDN2pPJKypW@vger.kernel.org, AJvYcCW16FKXE/sldSFFDu/2ZTQZT7+wC3y7tpTg+pxA3MOR8oeARbdAIkiHdpOJtJ7641V40O8m/j2HSwBc2OyAQEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczU7EehIQwnbuRI3iif4XVpeScT5xifK+59LjWO2KjJG8icRq
	1MBi5BpxFLcrOJL48YHiWfgrbuqCgafG+yDSGsRk2BrLDv4SqdmqlSQvZbBkm7xsRhni/qoDIpm
	mrJqDFdH+o2t10UGKVSpNyoeTh9fmLnikTuZG
X-Gm-Gg: ASbGncsC6Uxr0ZNXlc3mqqX1s2CHrcNEUMABxz/VijgGltiMb1XDenb4rQ3vYXVFXFa
	0jbkPHrNEF3+9+Z9U/NRtNHM+q3ci20q6iGt59pbSrm3KuKcCSFLrFubPRf9LO0nCxyuV0RdtHP
	8D2VLKgXYIsGPqPLiEU7lpzt17Ql9Z6Lr10mADDkSV/NHI85PtJcqfE+5357eGb+BBXjAhzGb5V
	4RUVBiSUA==
X-Google-Smtp-Source: AGHT+IGh9TCwtR1WKxzRY0rshSB2+iGJEdIGlFZwz+wb9MMLsAGk8u9hKkYJYbKgcwZR+6WwZaNU6x/vO0LU1KzJG58=
X-Received: by 2002:a17:907:f810:b0:ae0:a465:1c20 with SMTP id
 a640c23a62f3a-ae9b5c2bf92mr233596566b.14.1752562402868; Mon, 14 Jul 2025
 23:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711085514.1294428-1-andriy.shevchenko@linux.intel.com> <202507142224.28276C2D8@keescook>
In-Reply-To: <202507142224.28276C2D8@keescook>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Jul 2025 09:52:46 +0300
X-Gm-Features: Ac12FXxSNjk8tnydrSTR0JdcGDYlQAyFDPLoXHta3uSgsvf7uehbX5ELNIJal6Q
Message-ID: <CAHp75VeWvezuhKx-Q4hHV6=TqbHx=jEmR1wuqEzdJY+xUv7OAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Group str_has_prefix() and strstarts()
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 8:24=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Jul 11, 2025 at 11:55:14AM +0300, Andy Shevchenko wrote:
> > The two str_has_prefix() and strstarts() are about the same
> > with a slight difference on what they return. Group them in
> > the header.
>
> It seems more like strstarts should just be a macro around
> str_has_prefix() !=3D 0?

This change is only about grouping, but if you think it worth
modifying, I am not going to object. Just that I am about to have my
vacation and I leave this as is for now. Up to you how to proceed.


--=20
With Best Regards,
Andy Shevchenko
