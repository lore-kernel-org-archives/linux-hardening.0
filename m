Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFC1F17E
	for <linux-hardening@vger.kernel.org>; Wed, 11 Oct 2023 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYC6Msup"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B19092;
	Wed, 11 Oct 2023 06:22:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so1322117a12.3;
        Wed, 11 Oct 2023 06:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697030562; x=1697635362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwj/RqxGPkzuOtK1UNPuFzJw65gTRa5z9/nkxrTcS64=;
        b=ZYC6MsupiaErp9/vvfK5IJobPrJiU2P6gWZJabmg/r5NTx5wuKbZ9XyILFEEGcT/AU
         qHfj98VlV1VaQ2rjqcdg6cV/MaxGDRjBDHTejVY0PECZBAPot9xTerC7xA1aoAu7+EOE
         Q/hdBtuyDnOsIGpQ/JF4jzDErlNlKWLVnZ0PTXEzHskErChwphU4ofGBc7cs/J6P90jh
         aQbJb8fdBABQ/6zHCUK8d7XVqnanfWJu0tcnWrlszW4rXDq/8cq6Cdj5RBOIJ4WvbYOC
         AEzjHruGPCttDutnZ3XoabPAzVyqYVEbwT1sOMifly4sKY5FehAs2FLCb8MwQmtMjXss
         1Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697030562; x=1697635362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwj/RqxGPkzuOtK1UNPuFzJw65gTRa5z9/nkxrTcS64=;
        b=OaOh1gBSH2USvdfOCoXiCeV0ATIL8/GoQLUa1dNoDMvq1aPnamITaXMMI7nCqrbjfA
         PHmI0aVOkJV+2qRtbjldiVF8n17qjegnm7aknUcroUVvNEio094jnkfFFhpSRz+0NAic
         OtZFaJ1TJfkRkMdxRDlgGwdCtB4zU3G5r8AImEPx/QgcNDDwwCKCiTBWx+EBQjAcRbs0
         QCgLHnvhn8RYd6+lxAG7TLqtE/QQR1B1xTWSFDUlSa+hI+l+VBA2DeVqMrXCnXqdHRjx
         82D/eMl7SekbiegAvQA/lajZMD76H4LRlPAS/geFAg8QBP6qKS4tmERNNdrO4PSiBkUn
         l6fA==
X-Gm-Message-State: AOJu0YxOXPTayiVvT9rGohoqXPj39Hojt2uJrTbcBL8/QQon0GzChbH5
	xz2bO0ibfuSK9OF7vmzs8YG+2kJlHUcTmIKytZRt2xHB
X-Google-Smtp-Source: AGHT+IFjwPBdU24OWt+9rcNzyGAp61bEypdrM0CvK15jqMZomnmNG0qOl212jrCcTf9kSexYP8Ppu/QQjvKHxhdmt1k=
X-Received: by 2002:a05:6402:60e:b0:523:33eb:1103 with SMTP id
 n14-20020a056402060e00b0052333eb1103mr19266775edv.14.1697030561468; Wed, 11
 Oct 2023 06:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZSRMosLuJJS5Y/io@work>
In-Reply-To: <ZSRMosLuJJS5Y/io@work>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 11 Oct 2023 09:22:29 -0400
Message-ID: <CAKf6xpu4vQSKFykwygcCtnnJtcQbgVTuaNvAwDLeV8cZAectHg@mail.gmail.com>
Subject: Re: [PATCH][next] xen/xenbus: Add __counted_by for struct read_buffer
 and use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 2:55=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
>
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Jason Andryuk <jandryuk@gmail.com>
