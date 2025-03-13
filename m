Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F7143895;
	Thu, 13 Mar 2025 18:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892263; cv=none; b=BnDV23aiFwIg98MkrdaEjFNE3FiENw7E0b34E3+rxGZw822GxpXZdGz/JFPqTLe7GrErn1D2djkbMno0Y8OL/JCpuIjy0fuuJvzoYVUuzlEIib+IniIZQcBZ2+lwUCv1Yg9QS08AEmZDFJwEY2DnsqoGP68lUEjGcsLpvVqaghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892263; c=relaxed/simple;
	bh=pnM3/eXJlQYbAOmQMatwU3RDryh3qaaZieUTqjGuzcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlhO1dA46LkX47DckEfQxlKAvJqiI6PhiVeyBkMZ55AF2f8xwNbtjypYS/13UZAF45fzILiHlZa5nYl40ZNOmDyIWrksPFy4WIsfK5S2ILqr9W55lkgpYlrzXwhY6Docdrbkk+zZto+xyC2HmDBDFO/8rbe2WNYkRyK1AYdUTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbUJ/Vgt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbUJ/Vgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F48C4CEEE;
	Thu, 13 Mar 2025 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741892263;
	bh=pnM3/eXJlQYbAOmQMatwU3RDryh3qaaZieUTqjGuzcY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XbUJ/Vgt4NSdO9qOguXWJRHolBFAbh0mqx2ScE7onbocPyUmW+Y1RZs2bIFR9jOz6
	 KEp8O/6V58UaOAVIJeYcAh5ryZ+wKk4apH3HPcE4qBJsS2VgF5DHOVwuoVLEAVgqva
	 jnbveei5ls+7kt/xGLgtFVMsTqYSql/2QUMgsmv/gxL22bKMJOGAEiMdtWmXqQ2Ucg
	 +bdROyxh/Hrjznj7MJPNTBkcY1MjMm91iv+bp4Cl+7aoV9Quwgwh9t+9ZBT4eOtbS4
	 juQFIg47kMGZ3ZPIQnUi/Jx/kL27K4ptr5LgfVK851e5MgYpmLWzu8z3N4KzhDCzrN
	 dGzlaqzqndrPw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so229483766b.1;
        Thu, 13 Mar 2025 11:57:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaQ+w6vC9hGN3xCdplWaPofY4dbnY6OLw5YyWiqca722hAi52SXv5BcLJhywnQdKiSEe/aT7CQYtQTFqBoVQ/2@vger.kernel.org, AJvYcCUqCF8QYKMUFOt5PmoTBaOV8NJoY/O6ueQeJB/nA+iSq6u4Zn1tWgkLyMFz9O/fOlv/2x/gYVPu3jY97KEU@vger.kernel.org, AJvYcCWdo4SwihzGwzxCUnnT2ZamebFKYlfGlgc9baD5UmDV19pTHze+L1UqWGRkHBvTn8TLkNhIlFxoBvGC@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWc9yFx6UKU5C9yXj71CrDHxi6sUdXYu3n5wn/Iicw7SJ85ix
	e5+yK8qf/U3aQVsJelKmf9R90tHJbhQqEG762XSspY273GIqgxsBuTDIrq5yJBx7svXES9d4x99
	Sp13co1bD+veHG+Ms//GjYmnQNw==
X-Google-Smtp-Source: AGHT+IGxvyDPIkZ3HfnSzL4kE9l/WHzwDQwashvlehk6CqU5kYwwwa++MhzGCLauTSyn3LtQmieTQa9VDQRaakTmrE0=
X-Received: by 2002:a17:907:1ca7:b0:ac1:fa91:2b98 with SMTP id
 a640c23a62f3a-ac3290b5b89mr57840666b.14.1741892261803; Thu, 13 Mar 2025
 11:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741874545-19091-1-git-send-email-abhitiwari@linux.microsoft.com>
In-Reply-To: <1741874545-19091-1-git-send-email-abhitiwari@linux.microsoft.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 13 Mar 2025 13:57:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKU8hE=dXdQ+hO0WvU-GuXAjEBgCPJ4rnxef9851zyKMw@mail.gmail.com>
X-Gm-Features: AQ5f1Jq_oFazuB_slJkD16lfmh_exdSsFXOeEWw1Ss12ha7__KdFDzrMJ1oGPx4
Message-ID: <CAL_JsqKU8hE=dXdQ+hO0WvU-GuXAjEBgCPJ4rnxef9851zyKMw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: Document linux,usable-memory property
To: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kees@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	abhitiwari@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:03=E2=80=AFAM Abhishek Tiwari
<abhitiwari@linux.microsoft.com> wrote:
>
> Add Documentation for linux,usable-memory
>
> Signed-off-by: Abhishek Tiwari <abhitiwari@linux.microsoft.com>
> ---
>  .../bindings/linux,usable-memory.txt          | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/linux,usable-memory=
.txt
>
> diff --git a/Documentation/devicetree/bindings/linux,usable-memory.txt b/=
Documentation/devicetree/bindings/linux,usable-memory.txt
> new file mode 100644
> index 000000000000..167054d2e9a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/linux,usable-memory.txt
> @@ -0,0 +1,32 @@
> +linux,usable-memory
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This belongs here:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/memo=
ry.yaml

> +
> +Description
> +-----------
> +The ``linux,usable-memory`` property can be used to restrict usable memo=
ry
> +region. This property holds a base address and size, Memory outside of t=
his
> +range is not accessible by the kernel. This property is particularly use=
ful
> +in specialized hardware platforms where certain memory regions must be
> +reserved for specific use.
> +
> +Common use cases include:
> +- Allocating ``ramoops`` region
> +- Reserving memory for hardware-specific needs
> +- Fake Protecting persistent memory (PMEM)

All these examples belong in /reserved-memory nodes, not
linux,usable-memory. Go see the ramoops binding for example.

This was really for the case where you already have 'reg' (in the
memory node), but need to limit memory while at the same time not
overwriting 'reg'. Basically, for kexec where you can keep booting
another kernel forever. If that's not your usecase, you shouldn't be
using this.

Rob
