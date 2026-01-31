Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D071CAA65
	for <linux-hardening@vger.kernel.org>; Sat, 31 Jan 2026 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822253; cv=none; b=Y5BVbloRn9C9fKK3JIBqoCr5O/wmxSnu+APy4oHDBx9U4COh6QGKuLKdW450zAXN87WDG7W9y5VgMiC4OlC/1/b5eSeI/ibvd7zjJaBf8AgNmxv9RYCygzF2r+uJE0cH95sV2sL9c+UeTiLViyykaToEniKKPrcIdOoP8zCN6RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822253; c=relaxed/simple;
	bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNzQja7+e9V9FIkVGux1Y9WixhXtuwbGUBhrRsEA7LvNEaR0qIkoWDmbQiOQ2VERdmomIbOFsg9/oOhRPsIB1yjgrZW08gnVPeGYURj/FOQmuX1f5QrjZTcBKH4oUBc8f0BUIeN600SXu5ycf54To5W9EAF0OdOX/X+Lw95Hpws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcsQinas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcsQinas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769822250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
	b=WcsQinasmbFLsHNS0KP9nAYNYmiYYcskzw/7+H9l6BOvYH/AbP5IsECkvXYAqctUSwlDaY
	BT5wyizlpzDGvPKOPd3+8mTCPGtZvB+AjkpXW8FrbuInqLYTZFaz3cB1rKDp6Wj+GvYEVZ
	g9HOWMTheH4tDZb+2eNLQKmw0NzndwU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-FfunzoSXNlqB1v9nf5FVnw-1; Fri, 30 Jan 2026 20:17:28 -0500
X-MC-Unique: FfunzoSXNlqB1v9nf5FVnw-1
X-Mimecast-MFC-AGG-ID: FfunzoSXNlqB1v9nf5FVnw_1769822247
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-382fcf9cb7dso14739391fa.3
        for <linux-hardening@vger.kernel.org>; Fri, 30 Jan 2026 17:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822247; x=1770427047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWTRCN/AycRvbo4khjl5+VFeJJ9X1H7EUJUqhjiIGCk=;
        b=HvooBmaxCxq+eblSLlIic64pNt8nM5dCN3/x1oqVZ+i2lEJv2sZNUTQxFLkS2r/+G/
         QujaSztL6McIUJzfXJxFpWYogTx/k/fnnodVVdsyH01Hj/p3N8wfpDNHvvL/8hDmLSuD
         sCouIf4MVyPxwjBqzIZQj1xapn4GSGaxTh5VQ5nxfPNt+FBPm1mD81UIv2ShjdcKp/E6
         J6HzLKIwzKT1tdbNYMGtxhdExAD1DOChWDa3eWrPgD3lujROyTGP11CtiuUiWe9+I2MF
         kXn3BvoZc9Or7p3IX7mQPQh1FoHPTvdu5PWbz90828EuxXxcfXikSkb8rK0B6OLXTXz2
         pmVA==
X-Forwarded-Encrypted: i=1; AJvYcCUE85UuXynNnWSY+9n6QT7/8L/Uu4JiQAEMIdSk2cNIfbrHSilyBfQbyx72JkhVsGuu1vv7ZN3flWSViL7+XAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3+H1x8PEQHtQC1yNPf9Y7Rj3S/gHUoQHb+Z+aJnMTpcs5Tyj
	nmUgGlfexqp47a81A6tNbFQews3Hdlua5kFGRblCqnkiAfj3fo8GPRrvR7PQNjNPJBoqrXO63Cs
	W+OZwcDE5XzzOJKj2kcilvYBm+5/cfPqRiCQeZvzFbZYHtzFiZ0WaCekoqq1IcYwvmAD7cFnrpJ
	qeTkkoAbJcCyzA2B8KWi8G9tTG5AygLbQ5uidbkhhvJHeu
X-Gm-Gg: AZuq6aJzw+WxOV3u0Pl7+0rGuDGHudvvzOAwOfd6HCNMC9yuR6x/M9WVIl/vgiDXM9M
	xJRWsC7LXPtZqqzfHJaiKrkNhrnzwU93dRXpj7jayHic2ASM1fXZfgKXOSjX5tGyIHGmsr8HRq/
	/eAZCFwUp1zdwU5qdvUwBaxptIggaUxc3QneoUw6YORJZD2dkLclTluroZqq+rFaNymSXh41cXJ
	luFB986N+aAPOhOEemt8FxLQTzQ
X-Received: by 2002:a05:651c:1ac8:b0:383:1c18:adfd with SMTP id 38308e7fff4ca-386465246c9mr11816611fa.7.1769822247008;
        Fri, 30 Jan 2026 17:17:27 -0800 (PST)
X-Received: by 2002:a05:651c:1ac8:b0:383:1c18:adfd with SMTP id
 38308e7fff4ca-386465246c9mr11816531fa.7.1769822246613; Fri, 30 Jan 2026
 17:17:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNFbP3UaRokBxruI@kspp> <7d712992-e006-4787-95ee-e82cfa25f8ff@embeddedor.com>
In-Reply-To: <7d712992-e006-4787-95ee-e82cfa25f8ff@embeddedor.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 30 Jan 2026 20:17:15 -0500
X-Gm-Features: AZwV_QhMawgByiZ71sisK8DLL_VBMZnLRRD0cUo7moFtR891-SdiA88rULw1gIY
Message-ID: <CAK-6q+i0wNRRhhkBGNs6oP159vCfa40SjbrLPbQ_P1NXv2EmFg@mail.gmail.com>
Subject: Re: [PATCH][next] dlm: Avoid -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, David Teigland <teigland@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eoDEdwQrr5s2_wgWwvHoTgJDaxb-zqOuxn7zgRB-QCc_1769822247
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 30, 2026 at 4:43=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi all,
>
> Who can take this, please?
>

Sorry, I will take care that it will be queued up for the next dlm pull-req=
uest.
I just checked again if the flexible array member can be accessed
under the current conditions, but I don't see this can be ever the
case... otherwise we would access garbage.

Thanks.

> Thanks
> -Gustavo
>
> On 9/22/25 23:20, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> >
> > Move the conflicting declaration to the end of the corresponding
> > structure. Notice that `struct dlm_message` is a flexible
> > structure, this is a structure that contains a flexible-array
> > member.
> >
> > Fix the following warning:
> >
> > fs/dlm/dlm_internal.h:609:33: warning: structure containing a flexible =
array member is not at the end of another structure [-Wflex-array-member-no=
t-at-end]
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Alexander Aring <aahringo@redhat.com>

David Teigland can you please apply this patch to dlm/next so we don't
forget it.

Thanks

- Alex

