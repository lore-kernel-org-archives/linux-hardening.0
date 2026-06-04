Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF33B2FC2
	for <linux-hardening@vger.kernel.org>; Thu,  4 Jun 2026 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590674; cv=pass; b=uaQQxhP75J/0pXdo6HVKnBc1hxP88d6761++fUT1Yh5bSkkQ77jV2VLWNTvsVEppj4CJ4CGThxHZA2vRpLQc/vlRNmbNuCg9RwOoKjizl3ZN78XP9kTp8X2dIZkyjV5RzOinpV9iyE2NlKGQzfc+9tAcs1AQtBzz24mVrJwHkh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590674; c=relaxed/simple;
	bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5lq7jmVWjaFgBSy9RaLL+7rO6Ou1ubCfWxKoMEWk6OwuEHfy5cj9BFXmfKqK+9NVBHtUc4B1X/hVK5aUCZpMADxgSJYMo3Lqx2ML9Ww8uSPEGGRqzcCfgidj8VExq0/bm1nPsEW1yYvZvT+GPQbejNUz0v4yRJINhsibPRiDUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYizWBKw; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYizWBKw"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so989676a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 Jun 2026 09:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780590671; cv=none;
        d=google.com; s=arc-20240605;
        b=MtP48/mY1zue+hlJncHQSt/cLazzluwjMLUtpXeqUBQn9lwKlLhHcT5NJqv/gCsW4X
         GtkvL/tbBYKNweMoaFdtgO3hfzA/20c3gV4Mz62ww0GwUFAg7AfhDz2WTKcE4NUA5HCW
         MAPEwjex5AygNxBfx8wOrkzeAF6MWokAZjbbbwc5NwHwQkTTFRD6+cActEOD/mts5AUQ
         60UJcFd9gzd/2N+DGTfoqObrJINh7AVF7VXZ+lXx3wF2aHkSVJHAeEM0U4dWcXdKdZ12
         jndMcCF+RpoDQTD1Hucuq3mtLF4rmBKHvo/KGdMQ8/UdTbcbYZrJv0WnQIR8RU7vUcEF
         nBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        fh=rXuuDq/fPV86IewdJ1hk03hn0WjMqv2vdZ0iWTvzcT4=;
        b=IWBDyO8aA88D7HQzG2qUFyQxAD8SlnALF8lAbDdAvKXYLJSe+KIkb87aTsyET7Vv2b
         aKJXRdagtxVWfJBF5tavBnx6Rt72tBbYjctAfKd33mZKEDshsUe23rzwejG6eZqwvBhR
         byJjF0CgvbWXFy+F+YKvlVoLluUEVLyhDD/1IAOMfs88Ulz4q/8aPdNPuhtULnzO3BWA
         470RK56CkpdGvrHBH56Gt3vMWGoMmahhZwpJ8PccSTikmtgOGkHgKFUDbvok/8pUdmNM
         1rsYfDv5mk0wMqE4g0dogDJaPgcYTJPDw1luvTjUqki2fh3rsNu7XXYQIz0bfQqHCDGp
         qQQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780590671; x=1781195471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        b=LYizWBKwjoen9RbPlZkKqVX9HO4ohwNYKnGU+2Q+9RjwmmNdoOktu4fQ5uxRDDajqB
         JqvjdzC53gLKc+JjhUzLqrcRERtB4d1WOkPgm/YeY18fypdqw8x4vfGp30qDadQFg+mz
         3menY9qVtgPdGY3X5rl6F639jENH31rWDQQcJzfsLyqg8cD+EtYv7kKJliuvNEbdZqhS
         aqdvEPZY13QDBE3KtMnin02ngDuXdHXs4Aj/y7mBKBgixCgVmSKkgsEs9z/tSMDYdAN5
         PZspOYoGtFfvUL9v1bvQSMq9dXRTaon4BybuK0CmCpAfUFbHN5URmAZ835d3n0w9JhWf
         3i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590671; x=1781195471;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYQz5WGjsDPNgjJtpHPvb9PJr7MMreR1r3TlgYR8Xgc=;
        b=A9ql/iV7k8L9YGky1+kuhdjAvQ6G4tAw7L+22SpF0TV10yxExrT+tjjUwj6yB0wWX0
         o96lF7U6d6XmWwGG7iZcwEO4kuu+ReSC6u0tjAi4sC8FvaJvmJilfLFiGN3AL+JN/lEV
         /NekQVbiJEewpS4+A6vhxDmldbIq/i6860tnDswDPUy2PNwqj1cE6Wh7MG4Mbh7wEINW
         rWszwLgBtEvBNG8bFfzxuI/dbYOxRL2pblRvd5I70U1HOzPtN27O+aWnD63F5ht/keea
         kVrZizaZW6Er7UkkG8dSnGcodddIOQfJzW5MjEGCvTbY8+D7VJd3pK7+RV9wx4gZbOy6
         vA6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8LfMUK5J4Z8hhlKZa9F7iRRdeRrtle1j2mR80nc9hcrH9ovCzLDlwqxEzbnVD3NZQ6+KJPU2szasubX8nZvsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcw7xA8oBQkLcujOJ4n8MRm+QE9bfQczYUj4bZdFIe78UlUbuU
	g+iFEOOVeMykoLgtIYEnwCF35MIq7P4GlnLZWiKQqFI2KBqs+XJx+Lw9JjrkJ+Xdug7o0BE8dpj
	/PP3omv6mai4STbp6Wswu0/L9WX3QzxXDBeGSh3mjrA==
X-Gm-Gg: Acq92OHo1i5Uvs8IlXvl4b8mEtDSMgKmufHtUwP7ZqJ65ixrfkNr7jsWt2kI4+vonOE
	VVuMuqqzf5PbpBdk60lXJVtofbRp4+UeLIuCdCD7EEmK79AjQsnI5I43fq5mCfr+dPzbI5Xa3wQ
	RlggzSfqQMFG3gOduwmu8/N4YVpsRDBcgWv2XbGlkg0E7eBgfCccZTPy8KxNjP9yCqdshQI/8QC
	TyvmLfwv6AzRd3ogcvDMRqVUMndcMZYJk34r2aUegtb/ZSwdUS3gLZK2C3CpmQ+L6JGP7Z1oklA
	F8Nis4nf4Z+J7YAHJ5uoevWPFG8sTE2fwo+7gC0O5dgh0odX
X-Received: by 2002:a05:6402:3215:b0:68b:539c:d269 with SMTP id
 4fb4d7f45d1cf-68e710ebc51mr4808114a12.12.1780590670971; Thu, 04 Jun 2026
 09:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org> <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-2-0f1810a356e6@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 4 Jun 2026 17:30:59 +0100
X-Gm-Features: AVHnY4Jq-Cm1FpMQ9NjMzo61aJ4t188OLXQIR-HELOPptilenf70Fcb7QJeV21c
Message-ID: <CADrjBPoHXi5hp9T=z97k4LKNKQUEnJdN4sSz5g+NgKAGC6jguQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/5] thermal: samsung: Add Exynos ACPM TMU driver GS101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:00, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Add driver for the Thermal Management Unit (TMU) managed via the Alive
> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
> the Google GS101.
>
> The TMU on the GS101 utilizes a hybrid management model shared between
> the Application Processor (AP) and the ACPM firmware. The driver
> maintains direct memory-mapped access to the TMU interrupt pending
> registers to identify thermal events, while delegating functional
> tasks - such as sensor initialization, threshold configuration, and
> temperature acquisition, to the ACPM firmware via the ACPM IPC
> protocol.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Acked-by: Peter Griffin <peter.griffin@linaro.org>
