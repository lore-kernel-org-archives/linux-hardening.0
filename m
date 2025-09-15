Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E530230BD9
	for <linux-hardening@vger.kernel.org>; Mon, 15 Sep 2025 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958579; cv=none; b=Mdolq9m3NzNsrtKBaLBYTZX2O1T7GE/JzHS36MQVfJ6btxtB3eZJvPVXKQ4bikAu/cmpAnYK51Qc8pF0R7Cqm9audPuSDbS4gjme9wG0LdI3BQxL7O55e+/dY2x+c/w1hyNcnHv7K1Oxw2pnOwzFhv6/lF26mrdqnnzagsl/4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958579; c=relaxed/simple;
	bh=rM8+608zDs9i7OpttILcMD6pNVDYn26GPqUJwRJwjTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJLpoLk2WvPo8rjuaEHBM4v+VEgjvBNC2m6wrsxUDgwGZGhg+oucAMmaZdCN5R6ZY0IcEFwNUqY2Kn1cuIkHcAZpblrJxVTdnCOcs3eCdlnpP1fGyoN5FrIc35ZWz/iAGcqRbOH5HsPJyDkujVxPjT6oZZP7syvp6JAhcoVRtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jn6UXbtT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jn6UXbtT"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-750b77699b4so3634824a34.2
        for <linux-hardening@vger.kernel.org>; Mon, 15 Sep 2025 10:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757958577; x=1758563377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAZioqHrTQ+AevT9cWxUPizrYYw+CkCC2DIwykw40jU=;
        b=jn6UXbtTp+mEpa4UL9vp3/t9TPDAJOqPsP/ZGE7QhlkxvSvSbXhy6W/pdIPlnufS6s
         lE9TgIH+mNNCQbdJg9/3iRXsb0f3U5X/RwPlVIrY/Gv2dPsyIBBVjDZI9vs3QqZAAKA9
         EaBZ3MGE+2q0FuxRQjnUXEfL8kAFENsOEukEZS/huL7OxFfnrT8gDsw6PEBJf5AvQft6
         8RVYVaFoMflG6lqC5a2BZaty8HfGubY963ifnj+N9DS5qId7DckeuR9IWkRGouMXnDvB
         mWAHaKBvfnvHCnlTezZPZqNXA8p4a0jUn6aYcN/yzElU3CA3gFcNAu/Cyaka13jVPoMM
         s+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958577; x=1758563377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAZioqHrTQ+AevT9cWxUPizrYYw+CkCC2DIwykw40jU=;
        b=ToB7Ri94euIr5q32jEK0CghA2Wc2P78bsnLgkXTu5VgHdLi/l4ObsE4utlOjcepndM
         raCjnv2ohVEHY3JelVkBu1b2ncsD6sfcCN4FqGv6LtwwMayG4JxXkWbcmYgt/l1ew03/
         7VbnEVN1DQna+TVn580xrWzRb7knjiAxHHvcnf2cwyMhcF446rBGNDeHkUalnwC93DDu
         PxyJ3zXLeItWBWkXxhoTagWKG2VxV/456nNb0iUCD6fk1mBSLb1BvhP4POyZoTp7Ucwc
         w7JpSRNJy1706vyzJbTsqkqkGY7lETjezJIN0i6RtkDm+vxZv2rVy+EawJOmk9ch6vYO
         Xu1g==
X-Forwarded-Encrypted: i=1; AJvYcCVq++5Tk/1vZ5ndL+j8Wnpo0TBEuGV7JddmzG6qYBziLEiEl6zOzSRLLKGHUHmasAFeXgy2osBY8gMp4akcGo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkzB17jlkZxJlwwx770OgXznIR/YghXLDNOjsL7lUGaEfzTGJr
	gaGpx6Sjqk/uhpET01M+8gvnZGdFeh0ATApQHr6Y5LIqjNcaGNLFkzbvr5OsBl93Bjm4S2Rse72
	uggACnaI4vZe9BpAS+1O66HnFov0EVFUx9NfonEGU5A==
X-Gm-Gg: ASbGnctLBETzm0NDzkt1wv8nCm4rr4PbvcHSDBYp8NkE/VCl4lBrcA3KCtcOrDza477
	ZIbUs0J35pYF+0U/uakMw/rqh54c6lLUE9gVCrboJO2mVbzG0goke7z6s1X9rfZZNczNRKajuFG
	W0m6fq1rhta960uFTlP0ce33FeQhAbu12WKPVcZdCiSBDJMAeBT5tcCIATUsr8BjhNNdvbVmAbg
	BOQ4h6V
X-Google-Smtp-Source: AGHT+IFH2g34vEwZJetBbwvZ3SomF8yWsdtaRubWzROFmfV7fPJWquu4ln8JWGnCxhfWDa7z7TN6AkCfw2+pHb5lOKU=
X-Received: by 2002:a05:6830:6ac2:b0:745:a1d8:9deb with SMTP id
 46e09a7af769-753529994cemr6368252a34.1.1757958577063; Mon, 15 Sep 2025
 10:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
 <CAHUa44Fow6BhkdTki=rt2psOC=dq99cRgwXsVagmQU7fttXyCw@mail.gmail.com> <mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y>
In-Reply-To: <mir6lhkj456ra3i6w7def4rrtzw663f66l66cz4s3gxxvueeqk@ils2hjklbp4y>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 15 Sep 2025 19:49:25 +0200
X-Gm-Features: AS18NWAR-VBm4g9R0EH1G3hbl6PkG8dirAOCNZkRJpCTr8DYOgGvR9V6YWQJ574
Message-ID: <CAHUa44Hb1NMCmqbquuQ=f=2kxPL5ik_2m_EiwvoRSew3niXBfg@mail.gmail.com>
Subject: Re: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
To: Bjorn Andersson <andersson@kernel.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 4:05=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Fri, Sep 12, 2025 at 10:21:55AM +0200, Jens Wiklander wrote:
> > Hi,
> >
> > On Fri, Sep 12, 2025 at 6:07=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >
> > > This patch series introduces a Trusted Execution Environment (TEE)
> > > driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TA=
s)
> > > and services to run securely. It uses an object-based interface, wher=
e
> > > each service is an object with sets of operations. Clients can invoke
> > > these operations on objects, which can generate results, including ot=
her
> > > objects. For example, an object can load a TA and return another obje=
ct
> > > that represents the loaded TA, allowing access to its services.
> > >
> > [snip]
> >
> > I'm OK with the TEE patches, Sumit and I have reviewed them.
> >
>
> Happy to hear that.
>
> > There were some minor conflicts with other patches I have in the pipe
> > for this merge window, so this patchset is on top of what I have to
> > avoid merge conflicts.
> >
> > However, the firmware patches are for code maintained by Bj=C3=B6rn.
> > Bj=C3=B6rn, how would you like to do this? Can I take them via my tree,=
 or
> > what do you suggest?
> >
>
> Please pull:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 20250911-q=
com-tee-using-tee-ss-without-mem-obj-v12-2-17f07a942b8d@oss.qualcomm.com

I've pulled from you're tree. I'm picking up the remaining patches
from this patch set.

Thanks,
Jens

>
> Regards,
> Bjorn
>
> > It's urgent to get this patchset into linux-next if it's to make it
> > for the coming merge window. Ideally, I'd like to send my pull request
> > to arm-soc during this week.
> >
> > Cheers,
> > Jens
> >
> > >
> > > ---
> > > Amirreza Zarrabi (11):
> > >       firmware: qcom: tzmem: export shm_bridge create/delete
> > >       firmware: qcom: scm: add support for object invocation
> > >       tee: allow a driver to allocate a tee_device without a pool
> > >       tee: add close_context to TEE driver operation
> > >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
> > >       tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
> > >       tee: increase TEE_MAX_ARG_SIZE to 4096
> > >       tee: add Qualcomm TEE driver
> > >       tee: qcom: add primordial object
> > >       tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
> > >       Documentation: tee: Add Qualcomm TEE driver
> > >
> > >  Documentation/tee/index.rst              |   1 +
> > >  Documentation/tee/qtee.rst               |  96 ++++
> > >  MAINTAINERS                              |   7 +
> > >  drivers/firmware/qcom/qcom_scm.c         | 119 ++++
> > >  drivers/firmware/qcom/qcom_scm.h         |   7 +
> > >  drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
> > >  drivers/tee/Kconfig                      |   1 +
> > >  drivers/tee/Makefile                     |   1 +
> > >  drivers/tee/qcomtee/Kconfig              |  12 +
> > >  drivers/tee/qcomtee/Makefile             |   9 +
> > >  drivers/tee/qcomtee/async.c              | 182 ++++++
> > >  drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++=
++++++
> > >  drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++=
++++++++++
> > >  drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
> > >  drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
> > >  drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
> > >  drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
> > >  drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
> > >  drivers/tee/qcomtee/shm.c                | 150 +++++
> > >  drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++=
++
> > >  drivers/tee/tee_core.c                   | 127 ++++-
> > >  drivers/tee/tee_private.h                |   6 -
> > >  include/linux/firmware/qcom/qcom_scm.h   |   6 +
> > >  include/linux/firmware/qcom/qcom_tzmem.h |  15 +
> > >  include/linux/tee_core.h                 |  54 +-
> > >  include/linux/tee_drv.h                  |  12 +
> > >  include/uapi/linux/tee.h                 |  56 +-
> > >  27 files changed, 4410 insertions(+), 28 deletions(-)
> > > ---
> > > base-commit: 8b8aefa5a5c7d4a65883e5653cf12f94c0b68dbf
> > > change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c6634052=
7
> > >
> > > Best regards,
> > > --
> > > Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> > >
