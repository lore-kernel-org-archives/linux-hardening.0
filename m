Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652799;
	b=tCY8i8oumj53H7WEneOsJIREqjr0bfuw01yFtykxfzdy8EZ7jsSft6Dha5FSPgQs1g59
	 PdZVWdfifREN+RxoeT/bVGho9GS48kbjX8DTAg4d04Js2wY2E2n3+eEbIgJnfv7br5SEu
	 84b8TcAkrurdv32fvBjvni2wMU1NVVfjX3G/j3D1rxIntW2PjbZMnRZsCH2aeP2jgSYCa
	 hak478yrRXMtWFm6h3IxzC0Xc5rZQXukSE7Ij6k5ahHqlOCHfAkQ25Y3QnBJoh1/Ju6aa
	 ZAMoRahsivzi0YatY5ztKEgWwLjqSwzQ4qDAF0VIbDrY57lL2tZ39AlO7fAZmnyDNYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652799;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=BWYLhT7JwH851bmgrXbkCoBCwpI/m8uCinG9PCHFCxmkjnsgLxMArdxWG1n5cnO3i8sa
	 UTbuM0C7wI5qEcc96VLIztYGhc4u7cpIJOuOmrIRrs72jcvD+frW/l8en6NyPUGR5Ax/Y
	 g7hWYlgf66h8YP5rHhby+8YVvSwcNH8GCkW5SC591RyYJB7QSCGShWSjoRCSj7dHTErx1
	 xhDthxrA0pE2XTUCb2dhbKny5nEqsP5WwVriM3UeH9fnefbNNbk6uLvXZiPhv5inUV0cb
	 zKtsnOLteCQl9zcZrEq921PAecU7dmVxfaGUU7nGEMn5WdIw1fNE9ySk4awuHSK/jHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37B606A327
	for <linux-hardening@vger.kernel.org>; Mon,  2 Nov 2026 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B37B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JrjqNRqP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793652792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
	b=JrjqNRqP10lz+xwTaT1N5hOMraQMewbNcL6ZPtYs/6qBeMDZq5lyggz1hz5TUE2wvCqKwM
	IXQbQRbVn/7mLpXXty1C0A86MwLFP717upzSrzHF5Nt1PiF43MqFrw00/Vf94oFs2+EMGE
	o+EsfhfOm9/h5ijPwHR98WSryq3gxtk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-YHYtSc-gMkaTIK7lpp9PPw-1; Mon, 02 Nov 2026 15:53:09 -0500
X-MC-Unique: YHYtSc-gMkaTIK7lpp9PPw-1
X-Mimecast-MFC-AGG-ID: YHYtSc-gMkaTIK7lpp9PPw_1793652788
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab3fc6e459so290141fa.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 12:53:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793652788; x=1794257588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=117yBiLwKENKL+3PiWG/U5OMCVmGd5cgD5S+cpkVimE=;
        b=BxnMR+z+Z9xoCxwwNbOIk8vajprZ8FSkX3vHI2c/xJo9wYRCuz7leeBg0JsRg7kgWg
         kyxodCxgYlRUURlOOSQj5OsJtUCXGHm9ZqH0a0PQk/fvWDtJ+TZtRj80caBkAlY9lpB5
         Z+cDe4U8QZZ/k3oIx3jomu7uRfQYJUCVRLf7pfF3wiGZJ3pWE5YGjBncklVEVz9RxSpA
         7j7aI2reMX2NOFh1eFTZ3eqIINq9jrX++PHjGozygibAXLt8n5J2qicdvzckSbL6Xd1p
         6Nm/x4zfgR3OKf6TDgIzy6xA+YGMz5z0ShVq81dCVm5IMZaTEncQRkbsN6+4qToskIYw
         O9bw==
X-Forwarded-Encrypted: i=1; AKwUvBxm/bhaJ+FAJDB6tUmx28OOcDMRTMJOyC+EO3VXfc7P+6DaRoQpUQ/9TewUF356cF4INSXrMjiFuYUGX69mxCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x6wza6nJYwlTfi9IURMkBCH3ekwMhL+vuPfVBpE0tr1K8s0DN
	urLkpPDH2c7RSactp3otGj7BsHRilcPx0SHJtM6eakJlvU11iDUfeYFTOrKfuv0g584BRBZ6YWS
	BMjgoRbEZvy7wf3UZTN/eOWwCwJ/6G233J00MNWz6k2JwYNVVV2LOAlsy6yxF4j4UrGT7hAZlgd
	K3t0w4Xhtw8Ck7PCTHmWcDcKsHcBosmhE11iSPyqa58vf0
X-Gm-Gg: AYBFou3lyBkfufMP2zAG4ib/gDBe2b75xJnXoaatGVHvtoC4/IM86CFHn6jIN3+ugGp
	URUHFkMtxafCO1v56CGJIhzrYzj8A7/WiqD5K+xqxhmd67ZCP3HPJuo59wYdKInVjOgEJC4qp1G
	wkac+V0vn5Rtl2X4gtiOBKZP+VFF2h+lH6+/yvncvfnqW5EWq3YHY0BrFh
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id 38308e7fff4ca-3acb7aa83b1mr20499051fa.13.1793652788242;
        Mon, 02 Nov 2026 12:53:08 -0800 (PST)
X-Received: by 2002:a05:651c:a14e:b0:3ac:4b79:573b with SMTP id
 38308e7fff4ca-3acb7aa83b1mr20499011fa.13.1793652787872; Mon, 02 Nov 2026
 12:53:07 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-6-irogers@google.com>
In-Reply-To: <20261027223847.652884-6-irogers@google.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 2 Nov 2026 15:52:55 -0500
X-Gm-Features: AclHuK8pGzNf4aGPekLa6NQcs521xOugw8djA3E8ZMCjZ7yn89XzG5j_wIaQNFk
Message-ID: <CAK-6q+j-MS_5St04YFU11LG_Cjf1jOuS3q33qk_iK=7TE-iuBg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] dlm: Free dlm_ls in kobject release callback
To: Ian Rogers <irogers@google.com>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iDtoPi1L-6QNlK-2Rm1lKfiyFqkz1oDDu3szsVR5xbc_1793652788
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 27, 2026 at 6:39=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> struct dlm_ls embeds a struct kobject (ls_kobj), but dlm_ktype lacked a
> .release callback and dlm freed the lockspace structure directly via
> kfree(ls). With CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, freeing ls before the
> delayed kobject release runs causes a use-after-free, and unloading the
> module while the delayed release is pending results in an instruction
> page fault.
>
> Add a completion ls_kobj_done and dlm_ls_release() to complete it when
> the last kobject reference is dropped, waiting for it in free_lockspace()
> before kfree(ls) and in the new_lockspace() error path before module_put(=
).
> Also delete the kobject via kobject_del() before stopping dlm_recoverd
> to close the window where concurrent sysfs writes could wake the stopped
> recovery task.
>
> Fixes: 3514faca19a6 ("kobject: remove struct kobj_type from struct kset")
> Signed-off-by: Ian Rogers <irogers@google.com>

A somewhat "big change" for just a debug functionality. Althrough I
agree we shout call "kobject_del()" early to avoid additional sysfs
changes during removal.

Acked-by: Alexander Aring <aahringo@redhat.com>

Thanks.

- Alex

