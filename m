Received: from mail-vs2-f40.google.com (mail-vs2-f40.google.com [74.125.227.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA62576EB9
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201184; cv=pass; b=SYTIRssprqWQ2LIE138NosKGNrseltE/iox54PgmOOK9LCTT9EAIoaiK9CJoL8CA/2UmQpUPpAbI+ds+ruWo59kmx1abW3a4IhIq3Gp9QXLdN/EWpJqRwmwcHgj5eiiqYS/iaBuG7qnbRmyjfrIT+jAtghKJqAtm8T1Jxlnb0iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201184; c=relaxed/simple;
	bh=AsWbvRuBs6JsB6ieQaz86pXFNDyRQud0rrGGSGlxzuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCcSDnWGcezaLNAUuqlSKw/6LxNoUad63QMMCdNgUpygLGJvU6tPH6THISSkTb8J4eMNme8hd1Dwhbc53eud3F2gxiZwbCDknv1nbcQa5Ndlm9WGN68sepn+lhMapGQbYNeDD1Del/jGkVInwhVhR4YLVg+0npiC1nGtH6ZSsvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HS3+hd2L; arc=pass smtp.client-ip=74.125.227.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HS3+hd2L"
Received: by mail-vs2-f40.google.com with SMTP id ada2fe7eead31-7ac5b4011a4so700706137.2
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 15:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790201180; cv=none;
        d=google.com; s=arc-20260327;
        b=ZfjDoXxmcKqwqVMNtrH/eT8eev4+BO2T3dcIEkzDOX0Y/1MlFK6mIKGLlKfE6Fpnho
         k2OYLfTJnNDEoEC4SyWw50r9y71HR0Ue4X3R6l9TNDFd7PtPqdndEAq3bd/R8mon26a6
         LfJ3jNm90xhkD9H45Vyr72sAgpMkDiUcLwrIL9lZjHegPiyjkUkOnfeUOOEhOfd7UpoB
         iiCKGWKmvtKvmJgYXJGc97NWB+WH2XIvTk+vHYBjVaJd3qJ450XEbr/MymtgWgFDuw5j
         KGCNLjTRvx7j9TvK7g42zit7i2Da5buTnMgiz8IecT1TyIxs86TjNaybhM8YXlKPw8VW
         6C6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yKK+WuchgTTwdNLrz4OxJ2b7Qi8+fI+db9UtwpFLIo=;
        fh=gw8jUpqPjihEuUagvjh8IGAc8ATjeUvs9/giOXfGbJk=;
        b=Ws6LVyInn1haGobc/qYBzr/h8wb7WRGaCzXgzdKZ47681SwjR2hpMAJE/CuqW8ozYZ
         lFQz10x05V0xWDrtSp6qfvp4g4JmgDXJYHEMajMthPdXHSB7xw09udtbp1g11K9GhaqV
         zIm6o3bryR52fQjvFV5e7k7TxtaZZWELB3AyiIZXbH5J88v5yUMlfRAjNtAfQE5dpIk+
         7GR2EM9viymGFSArQszssDMPKvBsSq3gFAiiRoiz1+CthggXXfQ2Lm4coHDnYyKwwKyF
         0lnh2gJV7MEnzxFZtOIa1qEpFBMyGIYelXjGVnO5M+3E9pvOAVbmQ30OgN8isYv1NzEd
         ewzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790201180; x=1790805980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3yKK+WuchgTTwdNLrz4OxJ2b7Qi8+fI+db9UtwpFLIo=;
        b=HS3+hd2LNIXxo51Lo08u/4zA+eKjJTYh/z+YZ/iJuZzIVK8UCdK2zz2G3TjboIMapd
         SUVSki8eM7T9Nxd/CABC7JJUIiPKL2XQcyfNAk0ng1IDvdUyebs224vozRCCPgcu4PJg
         OdVCyQIUkpDst0NEMsTutZJB7Te6Eros3gqVOVRoMPV9grBZeD1vx8dJ0hJFoQNDS5nQ
         RF8hwA4H6+RVxsL8a+FAAs9Zm9X8C9P3K0UiKr18rnvl7I3SLa1mbFZ1l5HwijmlynnM
         IBXhigQm+/Tnfn3Dd+O1F1Yxv7tOXw5H8XJawYndPvHbokkPm+54c5J+5y3c4BdEVeku
         Rrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790201180; x=1790805980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yKK+WuchgTTwdNLrz4OxJ2b7Qi8+fI+db9UtwpFLIo=;
        b=AjqvgxEpCj/2pGkhJw3N0Om41l6YaM+VNCvHqlE0TSkN0pJGyiZQJwCb0r9RXU4z6k
         Pl6CWhf/MaXmDkzUFZ4m25BMKApqnUETTQLELnhiMJuuL7wGuWR3i3q4a6rHsceVn6P9
         nAL3pWUuPz/uW5ZYF5x8oJVHgi/oFf3oVKjl6C8fFYvHRnvzzct6ohP9ILqJFBR8vgH3
         O0qfPRdM7fKiujl11ARv/Q8R3lPmUXpJwSmC/YdWWLLaY/gp9qVJWAf0QJhn1qoM+nr2
         HV5YuwgGHeI+4oU1pcMpUrM9BQlRZB8b0v20vnxy2irDcBODiEz1HmXEKAVmPIeOkUHw
         knfw==
X-Forwarded-Encrypted: i=1; AKwUvBwOUHooRY64KHKJZg6SVCD8Ll/njB7F8ociVZ+bkVvuMKiEqXmyiKwiYUVz825z0PAsT02VJcqHO6zDqdonKsA=@vger.kernel.org
X-Gm-Message-State: AFuF++na7PUViLUjahYuIFV1bGnUhZREZf61O2DPDCjHMcuQ8YxcaQ7T
	ND/FG5MWAiCRSQhV73G31C1KN30+Y/F3RxXnd1697NB3TlSJD+gRc7KxIajM7QGWg2bPuvgwBYH
	1Q/NmESC0023cD59z5BQTV2m5i7NSxJ18AE0lTWu6YEBOu3B3A3lvcVw=
X-Gm-Gg: AYBFou3bQbevb1azT3Ahz++u1URayeNvYIOqHmfthgMfdZJ+nQ2jFUKS9eVMDPHWD2Y
	wh9zZ3GemBRlbPMP+F+U2BBzrCezIhb+BoucstnyjnEhpBp57a0CDpc5dpTJeOrbe48jP5FO0nV
	YsagCGl1SJc2yOO4ZXdebAWjkt5x9tCSL/O/ZVAk7GQDvxpeR1CxhY25H0uysTXXJmxtxSkznXI
	DVa9udBAe/d5iAiYqXFmf2/4H3NlVYiczQn/RoFGy5BReRSWXf6y68wZQtX/j3oa4e/eLKG6XQh
	wK5XlF1/jT8pkJWz1t3CMCQQBGkFQC7y16pyxMIVtYEHJxOtxUb/ftfbJBvbrKiwytKNR4mXZbv
	929P5BfcPAcg6zVgVwBxn
X-Received: by 2002:a05:6102:61c4:b0:7a7:b6a:b022 with SMTP id
 ada2fe7eead31-7af38bbded1mr142471137.22.1790201179622; Wed, 23 Sep 2026
 15:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922112111.1970872-1-morbo@google.com> <202609230033.E3A658F@keescook>
 <CAGG=3QW+N1FoUL2GOLfU=U1Pj-eb_o99Z_Mq76ocrZ29S-NyZg@mail.gmail.com>
In-Reply-To: <CAGG=3QW+N1FoUL2GOLfU=U1Pj-eb_o99Z_Mq76ocrZ29S-NyZg@mail.gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 23 Sep 2026 15:06:03 -0700
X-Gm-Features: AclHuK_fY_1P8WjIOJbnwMFJqwDTCUFnN7YSyMbkDR7oEaQHX-fU05ol8keeeJ8
Message-ID: <CAGG=3QXAoU8cPQHFLDPa7KZGPWMEqS9iLXY2KeBt2us=K6Z6hQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: add __counted_by_ptr to struct st_sensor_settings
To: Kees Cook <kees@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:34=E2=80=AFPM Bill Wendling <morbo@google.com> w=
rote:
> On Wed, Sep 23, 2026 at 12:52=E2=80=AFAM Kees Cook <kees@kernel.org> wrot=
e:
> > On Tue, Sep 22, 2026 at 11:21:11AM +0000, Bill Wendling wrote:
> > > Annotate the "ch" pointer member of "struct st_sensor_settings" with =
the
> > > "__counted_by_ptr" attribute. The elements of "ch" are counted by the
> > > "num_ch" member in the same struct.
> > >
> > > All instances of "struct st_sensor_settings" are defined as "static
> > > const" arrays across the ST sensor core drivers. For pressure sensors=
,
> > > "num_ch" is explicitly initialized with the size of the respective
> > > channel array using "ARRAY_SIZE(...)" during static definition.
> >
> > I wanted to understand this so, in drivers/iio/accel/st_accel_core.c:
> >
> > static const struct st_sensor_settings st_accel_sensors_settings[] =3D =
{
> > ...
> >                 .ch =3D (struct iio_chan_spec *)st_accel_12bit_channels=
,
> > ...
> > }
> >
> > static const struct iio_chan_spec st_accel_12bit_channels[] =3D {
> >         ST_SENSORS_LSM_CHANNELS_EXT(IIO_ACCEL,
> >                         BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCAL=
E),
> >                         ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 1=
2, 16,
> >                         ST_ACCEL_DEFAULT_OUT_X_L_ADDR,
> >                         st_accel_mount_matrix_ext_info),
> >         ...
> >         IIO_CHAN_SOFT_TIMESTAMP(3)
> > };
> >
> > #define IIO_CHAN_SOFT_TIMESTAMP(_si) (struct iio_chan_spec) {          =
 \
> >         .type =3D IIO_TIMESTAMP,                                       =
   \
> >         .channel =3D -1,                                               =
   \
> >         .scan_index =3D _si,                                           =
   \
> >         .scan_type =3D {                                               =
   \
> >                 .sign =3D 's',                                         =
   \
> >                 .realbits =3D 64,                                      =
   \
> >                 .storagebits =3D 64,                                   =
   \
> >         },                                                             =
 \
> > }
> >
> > So .ch is assigned an array of items which looks to end with a terminat=
ion
> > sentinel. And .num_ch is unassigned:
> >
> > $ git grep '\.ch =3D ' drivers/iio/accel/st_accel_core.c | wc -l
> > 16
> > $ git grep '\.num_ch =3D ' drivers/iio/accel/st_accel_core.c | wc -l
> > 0
> >
> > > For accelerometer, gyroscope, and magnetometer sensors, "num_ch" is n=
ot
> > > explicitly initialized (and thus defaults to 0). This is because thos=
e
> > > drivers hardcode the channel count to "ST_SENSORS_NUMBER_ALL_CHANNELS=
"
> > > rather than using "num_ch" from the settings struct.
> >
> > Yeah, checks out:
> >
> > $ git grep '\.ch =3D ' | cut -d: -f1 | sort | uniq -c
> >      16 accel/st_accel_core.c
> >       4 gyro/st_gyro_core.c
> >       5 magnetometer/st_magn_core.c
> >       6 pressure/st_pressure_core.c
> > $ git grep '\.num_ch =3D ' | cut -d: -f1 | sort | uniq -c
> >       6 pressure/st_pressure_core.c
> >
> > Interestingly, the pressure/st_pressure_core.c uses both assigned .num_=
ch
> > _and_ a sentinel.
> >
> > > Since these structures are static const, both "ch" and "num_ch" are
> > > fully initialized at compile time and available immediately at boot
> > > time.  The only accesses to the "ch" field of "st_sensor_settings" oc=
cur
> > > when assigning it to "indio_dev->channels" during device probing.
> >
> > Heh, so the bounds check gets laundered. :) Even pressure:
> >
> > pressure/st_pressure_core.c:    press_data->num_data_channels =3D press=
_data->sensor_settings->num_ch - 1;
> > pressure/st_pressure_core.c:    indio_dev->num_channels =3D press_data-=
>sensor_settings->num_ch;
> >
> > > Because "sensor_settings->ch" is never dereferenced or accessed as an
> > > array, adding the "__counted_by_ptr" annotation does not cause any
> > > runtime panics or false-positive bounds checks under KASAN or UBSAN.
> >
> > I would argue that either __counted_by_ptr has no use here ("accidental=
ly
> > safe because no one dereferences .ch" isn't a great justification)
> > or that the accelerometer, gyroscope, and magnetometer sensors should
> > have their .num_ch assigned correctly so that the "contract" is correct=
,
> > even if nothing does the deref.
> >
> This is all very weird. Below is the full output from CodeMender. It
> might give some insight into this, but perhaps we should just NACK
> this patch?
>
After further review, I'm going to NACK this patch as having no
effect. I think this makes me a real kernel developer now? :-)

NACK: Bill Wendling <morbo@google.com>

-bw
