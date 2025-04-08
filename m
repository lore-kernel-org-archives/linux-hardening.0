Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3240F1C84AD
	for <linux-hardening@vger.kernel.org>; Tue,  8 Apr 2025 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089611; cv=none; b=Fiwvm/0zBmdNWVeY3waioHq8sbLOMYMTbRS9MPfbE9nwZlJ8CVpikU0G4u3BXEFkCnj1NbCVvCRkx5iFnDOCeNrdggeilLhiDEeZVft3ZDnclbqS8dNg96qO1eh1nfJaNbCnKlYkFLBl26phzW72VIDJmXySlH/7rzYXp9A2xR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089611; c=relaxed/simple;
	bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ3eUQ3wLWCzRcaUEuzBgnHET3mLhQyJ3DjuKy3Eu39sL7OFr0ULxMQMaIqEfsLQi+y23DE9k5AeY0nKBdr1jLGvjCWUb6gxSnOw3wHiBGX0dBqPDy+41S+01QvoSFqshPCn43sxFl86m3f+gxAApTr5edKUW4aBK83qU09mbB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ycp8js6V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ycp8js6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744089609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
	b=Ycp8js6VGyZT5BefndTNG8mFNiRC/GRFYarA5FTXwJq2A2bHQbRpuPHPRlzP2Ro8gxGR8P
	ajX/97ZaXNM74o5/0gf5/Woeo5G5CvkkOtkdy45Z2C0oKoVUS6bCuyQWR9vmTX2oF90JL4
	MB9+teaFTfJvxqFkAi2JwRIrzYMq3ws=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-WZk1bl5FNs6EnCivDTJnAw-1; Tue, 08 Apr 2025 01:20:08 -0400
X-MC-Unique: WZk1bl5FNs6EnCivDTJnAw-1
X-Mimecast-MFC-AGG-ID: WZk1bl5FNs6EnCivDTJnAw_1744089607
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-601c2ff0a0dso714080eaf.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Apr 2025 22:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744089607; x=1744694407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
        b=W6ZxsTTENKx3yCpPNn2UWFirCgQeO6BAvP8o56ewZNvt+YQrIFR/EyE+V3S9iYWOuV
         ZNJC+Hm8JmYDQYu/8JXogNZeCMWQdNOQqcwOUXupGmtRk0TGyaA6GzXEyJVn85nX87/A
         IiAeMA4hdeYOsF203+JWlHM+5UlZAGBGruakjJZOvqVFK+ek0Trffnc7iL0ezZNfJkA6
         VwB7KFVxynDZzbr1+MyrnAmsWXnY/xGDj5zJUjmFQgUq5aFVguEviTLu1PDsDzHsqdMF
         AmFP08eAD2S8jiDzdqfuKE0OZmestz3XJqCQIPzowUDoMqx4RaNRqasWEG3xF60TJy66
         BarA==
X-Forwarded-Encrypted: i=1; AJvYcCWv3tLOdMKtVcDiJli5/m9ZP6HP7EAUrHEvUAuK83UYrV0H8to9t3/nyMhnBX9okpjkk1dmzpitN+gXfate3t8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQesZ7Rx6YKQbWsTr6+XYA49LZzz9kMixd/mhwoaGJik8XDXyp
	oSeGMbPk4S66JBRMeKw9SA2LuBq4CC6sZNEOlK2jCPn//B0vyBGSDEk+kMyu0qh3PH9ModR2ReJ
	xH5yH735Mb7a68Rj30jxAJKDP+UEaH4+NIdlGZyg/WnMY0IYYwpv3Yclp2InVGg6pIF8h2jQTV9
	7uzYM+gCDh/77bmZEu3zSSZRc/1zBxjYbFksUUc1cf
X-Gm-Gg: ASbGncvP9XOsAgJGQ/EDGcJNlfB8VEHco5xtDN6hD4jt7+y9WYMNAm4uKYHU1ctQkmu
	ZXDWVNIXp0Yw9DU9ScfePlsRqu0Og9o5T2nWkcOV1//wREFt8xqYn8ERWLpHV53N8Uwgokr0=
X-Received: by 2002:a05:6808:158d:b0:3f6:6dea:55ac with SMTP id 5614622812f47-400456a460fmr3391081b6e.9.1744089607266;
        Mon, 07 Apr 2025 22:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFndQwFQTxqQbhh7/1XO26yh+0Bql7sVDUgvChNzviW902Do9tUiMP8jbpkd2ikbG9OPRvnppdBsFKJDjF8szQ=
X-Received: by 2002:a05:6808:158d:b0:3f6:6dea:55ac with SMTP id
 5614622812f47-400456a460fmr3391067b6e.9.1744089606990; Mon, 07 Apr 2025
 22:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407173149.1010216-6-ivecera@redhat.com>
 <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
In-Reply-To: <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 8 Apr 2025 07:19:55 +0200
X-Gm-Features: ATxdqUE8CZctw0bSKyYLZFAm9WOiGKPiK7Kqb-GLiHvQfp2TsbW9P7zTG2qlt-E
Message-ID: <CADEbmW3Byn8a4otcHqHr_=p4s5kKFq2D9N9xouWVr_0VX3ZikQ@mail.gmail.com>
Subject: Re: [PATCH 15/28] dt-bindings: dpll: Add device tree bindings for
 DPLL device and pin
To: Krzysztof Kozlowski <krzk@kernel.org>, Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K6p_nTBoEm6v3XyFZamUu4aklz-M4SwjGRdxXDy0OGs_1744089607
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 8:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On 07/04/2025 19:31, Ivan Vecera wrote:
> > This adds DT bindings schema for DPLL (device phase-locked loop)
> > Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>
> Did this really happen?

We have been through several iterations of the patchset internally. I
pointed out numerous bugs in the driver code and suggested cleanups.
However, I know very little about DT, so in v2 we should omit my
Reviewed-by on the DT patches.
Michal

