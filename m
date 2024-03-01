Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585FE6A8AD
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299555; cv=none; b=j4OEReZKtV1JxgCKeAB3G0DMLsqvAv3riA7wdpyFMBBb2EbN/6WC9gz4ovoGFUn4wJ6TdYSil206Cw7ilMVKzOK4gRUscbfvklpyi5gamRm35GNM2T2UqTMIUCVwxyzeDyVzsofiT7JaDra0GHhvgm1v6X+QGBQIYIASzqqWS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299555; c=relaxed/simple;
	bh=JHWldWA6nNHKcTRlr05zV/nwVzVNIlbYVSMFB9iJlos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBKe1p4UzdedMrg2VqmHE5bujpGnUj2ZHK0aRoXR9sL2+wv2MCycgMZxC3Ni5EoJ1AbFcp4n65qVohGsQk0X0v+wY1UeG8xM+UB23YJZFydG4Z0gK2OqlxWCh05fDvJlAzgi6a9B6ra9/4MxrynF0cl4kW8loRBrdxz4/dTuXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+Q2+3Fy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+Q2+3Fy"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so5944a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 05:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709299552; x=1709904352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=B+Q2+3FyhzzHOF8F2GLt2wkZhMidxgsedxhsBtInm8nvf198JXT1DWUuF0u/356Wxn
         bHie3f4Uu/XHdrg+Vfa953FWhqx8oTkSxkHOqiW2KnCzAx7R4cD2NPj2TsXquakIjDcE
         76UQQglv9A6OGSz2uwzZkR8KRPH8tPj4ZZe2hogP5p7bxSCh5+f3aUvhHjuq5MZHp8P7
         7M2KrYJhNfbtyRCQP89PQJ/FD9VfpkinyagzG8V2v+DAKiZ7P84LOwrPvC5bXiBAILiy
         Ra0kWb1lgODBF7kJQfvGMA3m9OzYX4TpQbrPd4MRKf2eJIzvsx2D4eOV8BvrxHB8P7Su
         094A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299552; x=1709904352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1teAiWc1jVGCssi6rgN3jeMMtmC7N9NmiOj97TQSRI=;
        b=AL1x364FiW5YLZxY3TLRH1cnAlREZKqdrsEv58Dpr8zXiGVuXYIBPzuf70mIahF33+
         ALNRuoGCipNAeKClrwHO2pLiFut2VfhMp5jOnMi4wfzXdhp42MYi9RvCnd8IULEN1vlL
         VEvzGFZz/WoI7fN3rJDNNoLd/XO8LEMLlF3yj7Hg/7mBkYMh5QEDgS9oTWdsHipUST4H
         6kSwfeDX7xCyoTInIQoTG00Q884z/xkpkqOn1pALkE+pQ/0yIJKOa6ev+KpGRlah+6ku
         T8xwe0Sg1YD1hNxAxLDasclcmiLb2V3UUhd4z6FrCYcus9sVECVO0ZvWAf/CGG765/Ti
         NtEw==
X-Forwarded-Encrypted: i=1; AJvYcCUy7QNuXbx5AEWXo6FA5V0zFdwkaMtAxHv8WjnHf7PIQ+5j0a6xIzkts7LA0vaGDQQvXI9fj8Jy6Dd5PIoOSJCR2aylq91wlL/iZsFbJBXH
X-Gm-Message-State: AOJu0YwhiCIDnr9SM4TshB1zZBXSx7vFx591RKQ5U9eaq8x0+pKGxxof
	keXAZp0gW1OJ86qtxISU5DGMuJysft/qaG4EScHDL/bYcTDErsnR6r81c226Oes1xLac2bJfTWg
	FZJDcI6DUwOLDuBIGehXOjF4LLGlgXymJJb7G
X-Google-Smtp-Source: AGHT+IHAr/zt6nB351plwUC26OzlBDCvnjhX4XuWJqRSF9vysrKL8/mndZ7DIMKjrKSevJ2zGGPoqI2B9cbCF0OdxRw=
X-Received: by 2002:a05:6402:350e:b0:563:f48a:aa03 with SMTP id
 b14-20020a056402350e00b00563f48aaa03mr141224edd.2.1709299551406; Fri, 01 Mar
 2024 05:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229213018.work.556-kees@kernel.org> <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com> <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
In-Reply-To: <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 14:25:37 +0100
Message-ID: <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Kees Cook <keescook@chromium.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li <lixiaoyan@google.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 1:59=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Fri, 1 Mar 2024 09:03:55 +0100
>
> > On Fri, Mar 1, 2024 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >>
> >> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
>
> Re WARN_ONCE() in netdev_priv(): netdev_priv() is VERY hot, I'm not sure
> we want to add checks there. Maybe under CONFIG_DEBUG_NET?
>
> >
> >>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> >>> index 118c40258d07..b476809d0bae 100644
> >>> --- a/include/linux/netdevice.h
> >>> +++ b/include/linux/netdevice.h
> >>> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >>>       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >>>  };
> >>>
> >>> +#define      NETDEV_ALIGN            32
> >>
> >> Unless someone knows what this is for it should go.
> >> Align priv to cacheline size.
> >
> > +2
> >
>
> Maybe
>
> > #define NETDEV_ALIGN    L1_CACHE_BYTES
>
> #define NETDEV_ALIGN    max(SMP_CACHE_BYTES, 32)

Why would we care if some arches have a very small SMP_CACHE_BYTES ?
Bet it !

IMO nothing in networking mandates this minimal 32 byte alignment.

>
> ?
>
> (or even max(1 << INTERNODE_CACHE_SHIFT, 32))

I do not think so.

INTERNODE_CACHE_SHIFT is a bit extreme on allyesconfig on x86 :/
(with CONFIG_X86_VSMP=3Dy)


>
> >
> > or a general replacement of NETDEV_ALIGN....
> >
> >
>
> + I'd align both struct net_device AND its private space to
> %NETDEV_ALIGN and remove this weird PTR_ALIGN. {k,v}malloc ensures
> natural alignment of allocations for at least a couple years already
> (IOW if struct net_device is aligned to 64, {k,v}malloc will *always*
> return a 64-byte aligned address).

I think that with SLAB or SLOB in the past with some DEBUG options
there was no such guarantee.

But this is probably no longer the case, and heavy DEBUG options these
days (KASAN, KFENCE...)
do not expect fast networking anyway.
