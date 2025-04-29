Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165D26B2C4
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 03:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897841; cv=none; b=RhbfOqWwn6q6MKEyxfYhUFC+7XozdDCrCagqkinq6mYxLh3xOuc5KEB62C40jvHwAX/0w3PC4FwYXsqimzuXyQfYzLiSDxsbtGD0p6vdfJ3Ozm+HpT0FV5oNpiHxMc/RWsWyHhUaoutXrbIObC1WP9uM72IHCD0tpqukHjneRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897841; c=relaxed/simple;
	bh=vZnrLPvp1SezavRSb+3blfciooE35zWcwCY/HASVrFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df9Ukp7JQDTlVv0ymvD6RKsEFpx30jsMNcGf8vEiB2NV5N+RephariCorQPR2zAt2jLxdP/tVKBfw3jrPueJX3ehIhFoTJpWsv4VfgfNDlB4+xnFVNnJYq35xYIsmoq+YInsFYI3AdD8Jti0cScw/K1YBwSrEZicClOtkXmqwWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=boH5feWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="boH5feWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745897838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtBx4B5toFccZ4nF29kycNJ0OC1KNDOrp48cQ3Ehw34=;
	b=boH5feWJT5Z4lS6HyrV6ftSRPQ61Ydqo/qgkuTnejJA6A6qHDAWXXK7C/1Xe+sjE5WBroC
	AcjzteHT0/Qc3FsLodoefbFuRk8mZAkp2BpK1O7kTetJ9/e4g/bSrAYSiaZNU/W2Zs2VDU
	uK6gCVXQ1nLJkZUH7T2ngMQ6BMw4k0o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-81EDXXx_PCqdMcKz4BCA4Q-1; Mon, 28 Apr 2025 23:37:17 -0400
X-MC-Unique: 81EDXXx_PCqdMcKz4BCA4Q-1
X-Mimecast-MFC-AGG-ID: 81EDXXx_PCqdMcKz4BCA4Q_1745897836
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-227e2faab6dso45931635ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 20:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897836; x=1746502636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtBx4B5toFccZ4nF29kycNJ0OC1KNDOrp48cQ3Ehw34=;
        b=GiImwt3b9OcFrmtxDk/U/RclzTyK4d6GQw9CI0yvvEYmw+H7bVFnCEyzYLcn1elaup
         fEuKPkSV8CkOjLWz+jjr+ZjwyBpenUwWocji5RP8aOi/BW4UbbkeE92ZGB1aim/inimL
         4MV22BfXT8accIFWdZ8aP4+1sqyF8wkN+yw+wO6z75SAqWjUi+hdG5Rc1ygtjyK4g6O2
         sW92+LxrLQ8LQhMt/YJxBkn4xo6qpam0+1wjkeTY9JErYSAfvup+40sIGbDd8s134Hhr
         1xbYhlTvEGytAYrDaWEZriWYK+tSIu8sXGbnazE1kA33BTade3WgPAUGsM9FV2I3NY9y
         w0IA==
X-Forwarded-Encrypted: i=1; AJvYcCXiLTvX5LKHXymehv1UjdKMHiEXy65MNeF796jsHWmZ0x2CktRO3Zq09BTS+H8WN3sVHMa0l8OYvtYDK3dSUoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgIRyppMyirQ3sAHNrtEplnXHx1syoy7pFXRoP3up/NjFrpzi
	SFR1vB+nJ7BglKiSDh1syf8AMcTEqJWZBOmRC2uAWj34YicY6wsl2OtO3vReQhDcreoaJXS9ylg
	TynBtP/NhDdMKcqeklIxUdSuc3RnQa4RADtmKGPp8jE4uxPLzMmN+UdsMLe2arPfvj3T4JogpRr
	Qr2GQArNA5NowgAycORVYUjrmAn+ajP6Pf+CRCeRJf
X-Gm-Gg: ASbGnctDq1g5H1EPFQhQmOWv/cWXQiO/6AwW1o4J/mi09BrCpIwREuJyFRJv+BuyX6L
	4AcWGZf2LIP4ltH3Lbtd7Q9QRPew1H/JvBpD2/yzuHiR6NMqhdlYHVJ1szoZVX3abZA==
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id d9443c01a7336-22dc6a0f26dmr163635215ad.26.1745897836102;
        Mon, 28 Apr 2025 20:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLe9pBRSxy4N+dD8KJSBtALGak10QhPScgb+yK1nBfP5vXL9NgrfdYgJEs/q16qDKuA3cYH0GoD1aU/5P+RTM=
X-Received: by 2002:a17:902:cf05:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22dc6a0f26dmr163634775ad.26.1745897835513; Mon, 28 Apr 2025
 20:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426062214.work.334-kees@kernel.org>
In-Reply-To: <20250426062214.work.334-kees@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Apr 2025 11:37:03 +0800
X-Gm-Features: ATxdqUHKrokOvlJhfFqnRSp5WKJr5Ro9UGb-ViD4ru9HrHYYXv8eFZRyEkZAZdA
Message-ID: <CACGkMEtPmDBsyHTsAMZ7aygPQ1CVELd8H4_1u4ySH4sMQXe=qw@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Use matching allocation type in resize_iovec()
To: Kees Cook <kees@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3fg2pueuCsve8_gFTYi4gEo-9ge3zwz0wDgRKXe5Xts_1745897836
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 2:22=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.=
)
>
> The assigned type is "struct kvec *", but the returned type will be
> "struct iovec *". These have the same allocation size, so there is no
> bug:
>
> struct kvec {
>         void *iov_base; /* and that should *never* hold a userland pointe=
r */
>         size_t iov_len;
> };
>
> struct iovec
> {
>         void __user *iov_base;  /* BSD uses caddr_t (1003.1g requires voi=
d *) */
>         __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
> };
>
> Adjust the allocation type to match the assignment.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

