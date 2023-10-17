Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C092D030
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPRPU5A3"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794E5B0
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:26:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so9939509a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697563570; x=1698168370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3sJOjdz4HmVX5Ee8oZMm7CVfPOQuCMEb6MVEUzA9CM=;
        b=iPRPU5A3XNNncjTScWnfjjRgn/g5N397H/BtEh9Wb1MvhKyPX1GjZ3RYu0T1JgLqrn
         fySYCLqE7D/js+nHNetHa8Nrndz17qAqJJd0/Is3TmNxbS9Fa8KgUSIN6IyTZPebz4I5
         rG5NJi0JbzG4kdUUnhboccde97OOIuKU75f+TzNS7Y0tDB2vBo6dYMQZWjNpaoPTxtuZ
         OQrrwdsSC68YNiiW+GDSkYusQl1pK76iZb91afaHFjPYvu6po5BanAj9dZXEbVHPvFTr
         vqe73Oi3fusGLBN5HEQAEm1hFxOGkcKVhLEBai1Q3QlxYjmcaHTVTXxjBouNwKmY8KSE
         ONPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563570; x=1698168370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3sJOjdz4HmVX5Ee8oZMm7CVfPOQuCMEb6MVEUzA9CM=;
        b=FHIP8y3tw5W6NRw8YIVLv0L+d5HedJsGwi7ZAjdS0E482q0nPcmCjitCuq0rm2nUu4
         AAd5xfwPPSjYyeq54ME8u3vRtF5+4JdvSv8K46frwEdX+4AFNtP7+Vc2jbR5WUqObcIA
         uDKOn1Bmre0gO2al/uYRQ0MczeZWp4RGva503PcCH5bB/pqgS2vSG1Ui4ebO0QiSdttR
         CIBpBxbsmvZcyKrpxTg2sJ4oMwBMw2nzqHJfWiBESUnWYZFOrrqupJbHVVvNIvgpqiM2
         vb5UNjTqdper2O4vpHwU6W+Z1oqpRJnFtj/KI03GSL+VeYq1ppbqM5BDScxIcoJ6z4+U
         FX8g==
X-Gm-Message-State: AOJu0YyW9O6wod1g5bw3QV4V8iNjCMflNxZUXyfuo/FIU2lupf45zUVT
	HTiipB9yxay4YDJLznk7oaGcWBTE31nVW70ABfT2bQ==
X-Google-Smtp-Source: AGHT+IHoa+w5G+1WhCe9EF6u7DQRQO9M4r38jyklDSYv3wWlfUUxuyT2jQDUZ5LPEAlUKpxXSAxQoovOtPawZoU+rjY=
X-Received: by 2002:a50:cd03:0:b0:53e:c2fa:54a with SMTP id
 z3-20020a50cd03000000b0053ec2fa054amr2314809edi.22.1697563569925; Tue, 17 Oct
 2023 10:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-ethernet-ti-cpmac-c-v1-1-f0d430c9949f@google.com>
 <20231016161353.48af3ed7@kernel.org>
In-Reply-To: <20231016161353.48af3ed7@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 17 Oct 2023 10:25:58 -0700
Message-ID: <CAFhGd8rjwEn8g0HXLtejyjv=L_0Gj2bCiE4fEcNnqhOqpdC+Xg@mail.gmail.com>
Subject: Re: [PATCH] net: cpmac: replace deprecated strncpy with strscpy
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 4:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Oct 2023 20:53:30 +0000 Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
>
> This driver no longer exists. Praise be.

Thanks for the heads up.

Ignore this patch :)

> --
> pw-bot: reject
