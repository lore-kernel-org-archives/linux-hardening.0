Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE446996C
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280249; cv=none; b=PFSez6qdgrCHDGPWBkEoeecSyysJdkDSQzzrc3Zsdqnll4h4xIZtXSnD/fTfAGAJ38uLFNUHmUhIgR6pJMhJEY2fOREL2CkJ5Z6FrdgiOJOi9htvV3D8dqQgkYUGaI6GexjPyHHf8to3w2qJaGW/JKdAzsxjkoNqdsauUCr97Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280249; c=relaxed/simple;
	bh=n4spHHvJLlMGZHVr7fqI5nbP9JLbO0KC62LA3csKOP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCT1a5NLA6AD8Xyq5wDM0TqBUhdgr/lcrxKSiLmQTU7MbcwsaVjoEx7AyofbUUaQ9KaMQwE7zpg3X36EZDateQjmVEaBqfhtW/b2w0Ob2uOTGaWpR8JSR8NkrKoRF8/Kl+FbWzA3AXoQOWeckDl5vwR69t8mRsKytFKWfrzje7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D00CdYJs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D00CdYJs"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3918a12.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709280246; x=1709885046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X4wFyOx0wdvgK1yfOcV9T4++P8vIrbb+J2WByTndeM=;
        b=D00CdYJsA9JWtnjZ+C9vhCytHtPJvdidm7Kmln0Yh9V3K45PHW9z6eQD5FM/eZaCwG
         1tLHQNUQdSFbLS8kOrs58u5rCu25bpdSeV8r0sOxk+ThaikPu1IkkPcefUYUTQG7jjpZ
         oIkZ0ZXfhTyJuT4sM1pneWLgZ0irXjNn9KWfvvnzdeb8OkRhjmWIjwjShu4FG+9tPiYW
         3pNq6dF4B4LVpoFI3kpxObmQUyfl9P0VoeeIlYDJoaA1XY5HLQkyhwTKmiRcMJ8g14oB
         BhSWHA3X0PojcKTXayhDAwRx96FhThlmBp9NGTJJ14mQriggwzqK1kxTltdq/IBtRBCp
         qmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709280246; x=1709885046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X4wFyOx0wdvgK1yfOcV9T4++P8vIrbb+J2WByTndeM=;
        b=aQdG0sFSXPzVl5EDt2veLeD7knVXa3jeG8R36tABeFdpX50EHx//BV072QAkiywD+q
         z66ROPRTZ6b1vSfqnZQ8/GDHj32IyhrVbRGNNr2VLuKa/YGk571r11acD0MUi8mUEabt
         ropiE+8/Gz3/2e7RlNP7DujPLm/BYtbOJM+sjOlUQbcl7rSJvwto0fHOPbLCAAlPRFE2
         Ds3Alc+sIhCShSiSq0BzN9fECxp9VNTrPQMFkcNqsXcSj0ds5EHc2iTKY1deKB+CIY5U
         qyHmTFaqXWdwomg2ydX6s2IiuvKle2sBrill2bQuo2S7UTJk52trqoz0wpXtscgivD37
         E+Og==
X-Forwarded-Encrypted: i=1; AJvYcCXs0Qk2llnzmiV/+p6p64oclrqir+hMi30Rc1kfdz+virwbFaBIEPuNBlIWK1SkAe2+5ztSA4GsGJJIAN4IOyC3aTww3BVpUKtmItbJyER4
X-Gm-Message-State: AOJu0YwhKPTWwv1kQezBiHD8kbCWHTwJPgo6sPkOYHgU00ZQkmLZCg2d
	gAhK0VEwEJRvkWarBGeACvdwYoHw1vcJ4e2UejVmLXEJ1+OUFE9Yy4WtGbbtcvFYifDImEYUBnN
	sp6si6vENapBLf+/s1/WqlFhu1+Z9fE7EEgjX
X-Google-Smtp-Source: AGHT+IFOvZyHykyduIz94CdHCof11T2iEVmpeMxGsKXRX8OsG8eBWy5K5UWwwoNyQqGC7PCA+EV0NmT93gNYH1arh0I=
X-Received: by 2002:a05:6402:5244:b0:565:4f70:6ed with SMTP id
 t4-20020a056402524400b005654f7006edmr109469edd.6.1709280246294; Fri, 01 Mar
 2024 00:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229213018.work.556-kees@kernel.org> <20240229225910.79e224cf@kernel.org>
In-Reply-To: <20240229225910.79e224cf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 09:03:55 +0100
Message-ID: <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, netdev@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li <lixiaoyan@google.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 7:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:

> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 118c40258d07..b476809d0bae 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
> >       NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
> >  };
> >
> > +#define      NETDEV_ALIGN            32
>
> Unless someone knows what this is for it should go.
> Align priv to cacheline size.

+2

#define NETDEV_ALIGN    L1_CACHE_BYTES

or a general replacement of NETDEV_ALIGN....
