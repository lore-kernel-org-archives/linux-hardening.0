Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27F36206E
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715084; cv=none; b=ny+IiTtKx8+RclBWH73XMtQXLpJROHXXZ3UVELkeoOeSAERZLMxz7Nr1mbNWol83rRP8Ya6T4JsLTS2VBdK0yzC9k6Ae4BShupxM6Ack2iWDpWDB8WRQxdzc4mu3psxNzmsO2cf0FGauPyrhaX+nEEOXlPzf2j3eAU81F2KcxJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715084; c=relaxed/simple;
	bh=SbE2cgv2kQcmjvErb4P8aWuTkv80m0Jw5VHNYIRdjbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4Z6xWPy1mSTGUfvfdpka5FarYe7eCJmAmvQYMPvQY0iyzlUXgKyy5dNb7qTODFWqXbjY5areBpIgUu32wARdUoSvIulmB4VDtIqDLA50Wu7fsXRejg5c9EN9GCZw8XktPJHx3dYUm+dyjr2f3AyFRDMB3wjYfOi/jf0EXyCwqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4I8qU5z; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4I8qU5z"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea0150ee46dso1986190276.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757715081; x=1758319881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKCZT/K4e4byUQqhyOs9c8fQ3Jbf6/69LbbDKjwZwLE=;
        b=H4I8qU5zYYIajG0cFBKg9XLkC+arvjtzsJSFXvheCL6rEFjkBDjc3hegecUkfboRZJ
         o+YKR91VOx5F4mC0NBXl1rGgTBplAfhta0YJG18OPylwKqPOunK7HTNz2EPsOewmiZ7b
         Bqxs/BsbSOTDAngNZiMnuhnORI7pSDWuf/FyvtAF5G0cFF+NNpjd7VBXJNIYdLsxy3tO
         8unUO2ooWffSDOCwop9ER6npWKnjKYm/uQ+3wcxMTLVNmoQ/tJ6Z3aQsDPRp6pM/gWsV
         f8qbeVEPO+hCJ7RRpn+rf90Ejl0TJuM2dxqhA2pdPJCfpeoHGBh8ew8oti7p0xQn2yYz
         HH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715081; x=1758319881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCZT/K4e4byUQqhyOs9c8fQ3Jbf6/69LbbDKjwZwLE=;
        b=t4WoeDTLt8h9+mH6PyLt29J/2nyRaemetqejeK5/na/rp+7+WiD032hriBR5Mnc011
         93KE+YS0KXibpoRqcHdEZeVUmQLON1gkiehLBaSMkvM5POZ4L6+MFYnCbPEzEsbiZ2UO
         Fs4BUBnYHumy/3rTbndUwG4kKLodtV9JeA3R9yq1MdK0z7vlRX+RUhXKoHeNCLvZM6qu
         kvk7eiZHVmZXqF2b/nPri/LqUfMLkD1utyEstGjhP80Ht7tvj1VQYIE8FSTa+WOMahmH
         Mr3wW+KWXXeimaGk0/tzQ0lVrIQXe+CM90lNEQpcjRF3FVzyGgGEYwMCIGpfccqmLB85
         hHOA==
X-Forwarded-Encrypted: i=1; AJvYcCWLOTvCWcUmzYVmYunE/o+4/e32h5v8fbyuaSF5uN6phZn1YDkFvsy6ZZ5bgKzyebF+fWeDh2GR/F7+pJ/rCMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8E5waiOh3j0Hb5NN7tW3742DAjCAbKIboGrXikxMLnvnM+ZO
	xoKU8jnAZ2M+kyU0FSMYsEaSBzVPD0pw1X5Hi0p2JgWstWHtt1bbj+h+db9qLEP88OC6A1UtFRz
	YoqEP0y5viiykwQxQRBc8mihy4RfR230=
X-Gm-Gg: ASbGncvECElncyCtje3od2PsIr0G/WmiMt8orMUkayt/vGrh1G0kPPhaYEOPNpvmJ7w
	BX/eFlXFJ0sYGsQJB1xrCSkATpoWd3r6CH32BtAW9sq7vrgQYdmzJuBc4xLJ6TTC/LQBLwrRoEE
	5fUaMn9vC2ihdwBLMi2OTWBY50tHmKpIVba7+Rw+mYJPR+nA8lKOeyzDfrnwqac58vbm6nYA9ha
	VUgXkGZTHFdpx/K3As6Sx+z5x0AQ/lYjoH9cwpPUJ9p9lw3epDe1iuoTbjYUifcaihODV60
X-Google-Smtp-Source: AGHT+IHvIYQO4e+EnIIRJTQWJn4b+DyuGOUZd4hIxE3/1w0g4hnoPddMFEkakoXj6yfAPLr17VsI/RA83QQAwziujdk=
X-Received: by 2002:a05:690c:4c09:b0:723:bd6c:4f2a with SMTP id
 00721157ae682-730625cd9f7mr37664467b3.7.1757715080775; Fri, 12 Sep 2025
 15:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-mt8196-gpufreq-v2-0-779a8a3729d9@collabora.com> <20250912-mt8196-gpufreq-v2-5-779a8a3729d9@collabora.com>
In-Reply-To: <20250912-mt8196-gpufreq-v2-5-779a8a3729d9@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 12 Sep 2025 15:11:10 -0700
X-Gm-Features: Ac12FXxS_5OX767ts7gHLmsyJJeyNECHrzeeo_cAOYq8vugrFis3NtJYNr5wYEs
Message-ID: <CAPaKu7Q+KAzEtKBWy8KO2Kp+H4y-Mqo34uo=jgH1_iooaDq3hA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mailbox: add MediaTek GPUEB IPI mailbox
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 11:38=E2=80=AFAM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
<snipped>
> +static irqreturn_t mtk_gpueb_mbox_thread(int irq, void *data)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D data;
> +       int status;
> +
> +       status =3D atomic_cmpxchg(&ch->rx_status,
> +                               MBOX_FULL | MBOX_CLOGGED, MBOX_FULL);
> +       if (status =3D=3D (MBOX_FULL | MBOX_CLOGGED)) {
> +               mtk_gpueb_mbox_read_rx(ch);
> +               writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_CLR=
);
> +               mbox_chan_received_data(&ch->ebm->mbox.chans[ch->num],
> +                                       ch->rx_buf);
Given what other drivers do, and how mtk_mfg consumes the data, we should

  char buf[MAX_OF_RX_LEN]; //  MAX_OF_RX_LEN is 32; we can also
allocate it during probe
  mtk_gpueb_mbox_read_rx(ch);
  mbox_chan_received_data(..., buf);

mtx_mfg makes a copy eventually anyway. We don't need to maintain any
extra copy.

Then we might not need rx_status.

> +               atomic_set(&ch->rx_status, 0);
> +               return IRQ_HANDLED;
> +       }
> +
> +       return IRQ_NONE;
> +}
> +
> +static int mtk_gpueb_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> +       int i;
> +       u32 *values =3D data;
> +
> +       if (atomic_read(&ch->rx_status))
> +               return -EBUSY;
> +
> +       /*
> +        * We don't want any fancy nonsense, just write the 32-bit values=
 in
> +        * order. memcpy_toio/__iowrite32_copy don't work here, because f=
ancy.
> +        */
> +       for (i =3D 0; i < ch->c->tx_len; i +=3D 4)
> +               writel(values[i / 4], ch->ebm->mbox_mmio + ch->c->tx_offs=
et + i);
> +
> +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_SET);
> +
> +       return 0;
> +}
> +
> +static int mtk_gpueb_mbox_startup(struct mbox_chan *chan)
> +{
> +       struct mtk_gpueb_mbox_chan *ch =3D chan->con_priv;
> +       int ret;
> +
> +       atomic_set(&ch->rx_status, 0);
> +
> +       ret =3D clk_enable(ch->ebm->clk);
> +       if (ret) {
> +               dev_err(ch->ebm->dev, "Failed to enable EB clock: %pe\n",
> +                       ERR_PTR(ret));
> +               goto err_clog;
> +       }
> +
> +       writel(BIT(ch->num), ch->ebm->mbox_ctl + MBOX_CTL_IRQ_CLR);
> +
> +       ret =3D devm_request_threaded_irq(ch->ebm->dev, ch->ebm->irq, mtk=
_gpueb_mbox_isr,
> +                                       mtk_gpueb_mbox_thread, IRQF_SHARE=
D | IRQF_ONESHOT,
> +                                       ch->full_name, ch);
I don't think this warrants a per-channel irq thread.

mbox_chan_received_data is atomic. I think wecan start simple with
just a devm_request_irq for all channels. mtk_gpueb_mbox_isr can

  read bits from MBOX_CTL_RX_STS
  for each bit set:
    read data from rx
    mbox_chan_received_data
  write bits to MBOX_CTL_IRQ_CLR
