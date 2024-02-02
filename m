Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904061682
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 09:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867869; cv=none; b=OQIBtBEUKUaKlLHsV+b8VwmV8c3282T/fraE0IaZqyobjfVSfp97kmxO4K9A2iB1UsfM5TuUqwgT1VJ559rjztz8cYHPjD8sTAhDqEnZqpuYaAP4GQdk6Oaxaui0ae8W2pIkEfhvCf/NcaGcnAFtCK57o4+usMY07HETPgLWNgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867869; c=relaxed/simple;
	bh=RRNstcIluuEvvN5q92z4aRkcZ8MPGT3aLb5LKkuQEjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDAWw2OvSxzLEV3VtvmzivTnzjWxW8JWpWFiiThfc7BZ/TImhX1VXRMVDgv1Y/PIVvmMbKbe2Swy+2rEHKiSuot64bpnVma6NO2Z/REmY2wNAva6iZKwPxgHRjfhZD+yGbxk749E346xZlewOqc+dh+Pax9Q1aH8AM2oAyfUBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WeNtsJI; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WeNtsJI"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4bd45397c17so693162e0c.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 01:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867867; x=1707472667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IQu4+TF2VOv8ovQWnIde7uGbT9lKBnDwIcv4xTfRr/U=;
        b=2WeNtsJIOyhyRtf5xVM1M67GxVS4hIF2B5bi8WITGqbL5zCPMBaz4PPLe2VOuSWuad
         Zxme6GUUjTB5ke3gmdDQrMIO/VuV/GUoZmoBKwebSa0TNxxyjJe1aTIct4JYlFArFuzb
         aT1hI2VMFqIkoajjRXKAtwlJiNiUlXaYu+Bf2rpdBS2+NIQDWIuxRTlGqJncevPCilpQ
         wb/E6pJLDX4KbuEuxoeZBnmSIR9na4WMKzicEuys7JZPBVJBFCxKKjht6LwW95SNqF0G
         w+Io3CQ8tip6NpschL4AU59L2TQcYjF++d/RwgsWZUCreDo94ZxixhUIulsz7s+dSf+S
         d5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867867; x=1707472667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQu4+TF2VOv8ovQWnIde7uGbT9lKBnDwIcv4xTfRr/U=;
        b=dIAJpAjwt8m9E7z6R5m+AkS3M5d/0Wdi+xyybIQWJG6EYkGkoSe0NIhz34uLccCivx
         3bDl0ncE2vxgL5o4KEIpXqF2A+nLXyWZqvEP2QNMAwB/0jFKs96uU9anqR1pyyptB7jz
         UOIVDUTdf5+pBS4By5/dE1RsaBeRuncMGxcq5D9+LccP6RFmExVdgRJWwwvptLkYU43o
         TTtnHjBcw8/C1iLWSJBOSffYPAou+6SXU0qrucz4FsmVT4wa0r3XDMeIOWpUJp+cBopG
         /8rWHil06LhwmD4tF4cW9u7AfuinO6DJhoKXc6E85Sje4Hk7qnnFh1Y8FVDQB1sSYxUF
         xQmA==
X-Gm-Message-State: AOJu0YwSMEGGaXr2w9ukPlbkFhPl4YLu2z0m0x38Lf9n757QZWbx5FMc
	qsf0PpyrvZci9UBiQqXWcqtymEF3F2Qr+mUWn+73vUSZZxAp3DSrnAOIroXDbhSlpTj7uUu9KG8
	d5ec0B2amqs+NlxS6Rku4f147OgRvTgAfK48z
X-Google-Smtp-Source: AGHT+IHTiJLAxvje2qeRnYi2ylfwu0CGEMli5/Oc9gFFUCxF9OtJiu3BECSx1oy2M3xdLanJWbD1dRTko3CfBgGQbcE=
X-Received: by 2002:a1f:f4c9:0:b0:4b6:bdba:8460 with SMTP id
 s192-20020a1ff4c9000000b004b6bdba8460mr1408577vkh.9.1706867867177; Fri, 02
 Feb 2024 01:57:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202094550.work.205-kees@kernel.org>
In-Reply-To: <20240202094550.work.205-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Fri, 2 Feb 2024 10:57:11 +0100
Message-ID: <CANpmjNMCBvdM7Ni+vWCQwtJbbVskOdjSA+gjhgh6R3dKRqjXnA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Silence W=1 warnings in self-test
To: Kees Cook <keescook@chromium.org>
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 10:46, Kees Cook <keescook@chromium.org> wrote:
>
> Silence a handful of W=1 warnings in the UBSan selftest, which set
> variables without using them. For example:
>
>    lib/test_ubsan.c:101:6: warning: variable 'val1' set but not used [-Wunused-but-set-variable]
>      101 |         int val1 = 10;
>          |             ^

This is the shift_out_of_bounds test? It looks like the neg and wrap
variables are volatile but the written-to variables aren't.
Technically the compiler just has to emit the reads to neg and wrap,
and can entirely omit the writes to val1 and val2.

Does making it volatile fix the warning?

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401310423.XpCIk6KO-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Makefile b/lib/Makefile
> index 6b09731d8e61..bc36a5c167db 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_HASH_KUNIT_TEST) += test_hash.o
>  obj-$(CONFIG_TEST_IDA) += test_ida.o
>  obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
>  CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
> +CFLAGS_test_ubsan.o += $(call cc-disable-warning, unused-but-set-variable)
>  UBSAN_SANITIZE_test_ubsan.o := y
>  obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
>  obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
> --
> 2.34.1
>
