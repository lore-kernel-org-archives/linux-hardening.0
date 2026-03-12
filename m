Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9280A932
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 00:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273851; cv=pass; b=orH6GNaLnW7v52AKppTh+2W1dFTFGBc9xmjx0nHhckGp8PzsuAqy505s243AE3VRuObR5+VjpXLCiy8s87vfg+btRyWsQNHVktKFZSS7BbO5a0f40pCzC8SAHZNBxwFm0/VJ2He0VpKQZgAF4Lx5nenPl6gBP9ng4zxV16rqPNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273851; c=relaxed/simple;
	bh=lH3gHK8JgFwpJnFN90Utv0KOC2TT76RDW6QWYb8m+gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcwPQG4Le9nZibiE26L1HlWaTJGv6rtsjBv/3fdoyOcJE/D814ZNpuYZpdwaD5RUysl/1fY2s3UGBQliLdHsDtRNSk82DPn3OAdOjVCWmrVkaNNy0y77TKuE4cU+Cw8phForivArcSs1fUbOLUYnqkkCs0Xdqd5CIAk8yr6VvIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWsGoPiQ; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWsGoPiQ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b93698bb57aso94715966b.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 17:04:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273849; cv=none;
        d=google.com; s=arc-20240605;
        b=h+Fh9CpMxUDbuXgNsSyPVJrqUQZLLJCSbonHZ3by6RrA/L0BJl682JCA8cBWYnIDtH
         LpHqEBWK4cS8sJtfgf3VW4xhhhnm+uQe9UPgna24bme3edf2lLQpvCVqaioYkhbPaONf
         2Q9HgViKqtWzxl8L0NxymnAsehYIDOoIY4F7HlLM+GpzTHSc/+MUxS/DZR6OGk5y88O7
         QCNEVSMCwyuLbZprFRmY84w/YO6EdYY+rxFd8OfseN5ZHE6gtgoAp+kUa7RhrPjW70Lu
         sse+nEbSB+4rcXGrRXqp+y8MG2wg0sFe640XMn1XESQF7OiKsT/DE7vD/t/K0gbIH+QJ
         lp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2C00PrMgpq/cbs73x7YWNvYZ0FSHQqyCkSx3QCysqVE=;
        fh=NsXmQ19sp6iX1szByJb4z1yC9ewH0qI2ijHiVZDeYqo=;
        b=GB+euQUpnVWUppwFTC0A6ZUCsYi4hy8FCQZtE+mnrjv4NxImCqctqSwnoIXfHNjwUA
         npeqcm/ViDvEZwugEooAjN4kRVqwiWkWsDyxeBK1Ra0RLNp04sh3Bo5+2HaAuZHybhiJ
         o1jDNN0lxBqHq22bvcJojR8eJLe3z/bes5c+g8dT7NlkQTdYhR897TiRrO1z+4obAOYP
         1bkJ/521ByMBe3BqgRfyFt58By/gEeYJ65jIUjZ8wK9i3GjSjuJUhiAQh7Yd4SxZEzws
         a/vQOtQPl5bVYBvsnIazYAtnTi6fDp3EE4nMwXPGPcbf/rYLdQZgiYZ59YdOPr9sDy9A
         RlZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273849; x=1773878649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C00PrMgpq/cbs73x7YWNvYZ0FSHQqyCkSx3QCysqVE=;
        b=IWsGoPiQnUkO82JikQrXVfx0ZXd2xu9Ep1S+klx/nAGJTZsjb3lZTWFC+sQHr73G3l
         s+6flj6KkMXF3s0AXtwKTATnGnnHLdNCBNl5CO4cg8Tjw6t+zIh3LzrHm8ciVtR2Tnd0
         Ig0sp+nBc1O+UW48F9QwY6iRdnT1GKlujlcDwThhJv9ocgNFyKTjmJ4Jon/+frurZ3Ij
         RkKdnhLTeRRJS6qmlBOes6J3XHbWwyzeuyfWynq1Pz04CWy8ciPe/XDyhXtIIs6jcFtW
         J1ntjw9+lKtrAEPa0kyOn+A3/8z7msoHchQNxXTGtGa73yZZee3coxa4znutztekB3VH
         jqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273849; x=1773878649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2C00PrMgpq/cbs73x7YWNvYZ0FSHQqyCkSx3QCysqVE=;
        b=w86wBSts6fr7KLfxvBo0SjOySZU8Q3dIMWShGGAKk8tXBJahNtZ9IfRKKkYwQ3XTlv
         O2PLxnKAeUq6ixoUzDS39RLh9YQRZ806dOR5Aak1f9Ol+XcZOR8XOuBhChczvAMvPK1u
         s5EZ85H5POPp+bOVZKZ/cveeooynqAbBgCSd7CDxWFAWzCz0CYnaFXE/Nm+LpCbfsLji
         b+l+EUxb6djlX45+15+Jiy468rGNNsM6LIgR8Kqgqs0DaJZk/T4BABiG0oQhbrOrwRdX
         aib93c5zQsV3MkMBgozT4GKMfpNGqDGl0oUh03tHyRtgIzPN5dDd2zMgsZFuGnvUOz8g
         0PYg==
X-Forwarded-Encrypted: i=1; AJvYcCXOXnyBuJO2D7uHBRACsUiOESVI38Q3xSE0vyoayMAVCfvvVWTVcd4skxvngQwhXWiQ+sZ5WErlbXi0ymWvp+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/Ba8+M/2qO6nrDSCYMROUxYT6kmopkgNj5gP5LlvdSOYDS5V
	L8+HE1raEgjIw3kdC9wAQ/1HO0AzO3gNfCdZkovOP6kNR2T2Wg1rnBqB4oMLJ4lu0M8OaRMzr/e
	xfojjjpC85LfdQSpmNSIc6NR60KjTSug=
X-Gm-Gg: ATEYQzwLm/0fZH4Guad8FmOKoUyQiXgj8F9KdK5qOftF+sMLE8eGnhkF7enktJFF+vl
	7nsTFzLgfkvS3UEg1zvQvKAAY20XABQaYm+Ek+ZvxvpDb3UUHaZTNxiriOLzf0IoxXtHY1VSHgm
	82QbXcViiESUJt6G6NQ87hqPuE9q4cMe7c+TLaAR1p6z3bnTLIiZ1AhNzI04zekKB/1xvh8cSLl
	tSKWoFL2XYVzaXmYI7oWUNWrDaU+E+WsoIC626iff7n0imptBczzWRfpZTZqnhqCPjBWuG0EOMu
	prOTtb5RhAW335QXEnrKMi40+iYXWXDfcbHxo/7/+CQ9hc3q/tPatLxxL/N1VlltrUs2S9HKZ2T
	tWUkJLA==
X-Received: by 2002:a17:907:7285:b0:b8e:fc90:7119 with SMTP id
 a640c23a62f3a-b974029896amr88826566b.30.1773273848952; Wed, 11 Mar 2026
 17:04:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311232545.18492-1-rosenp@gmail.com> <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083C3A677F5C906222794A6FC47A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 11 Mar 2026 17:03:57 -0700
X-Gm-Features: AaiRm52uYDddCmjNDdUTN4S_Hkb7R1-RM6NSRAd80jU3e30getFJyM-T7oz7Lu4
Message-ID: <CAKxU2N8zSkzJMp85hgRN453x8bcPDvN_3tXmp-sNfueZOAuHfw@mail.gmail.com>
Subject: Re: [PATCH] EDAC: sb_edac: use kzalloc_flex
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:\\b__counted_by(_le|_be)?\\b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:39=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> +       sbridge_dev->n_devs =3D table->n_devs_per_imc;
>
> Do you need this? I thought that kzalloc_flex() filled in the __counted_b=
y field of the structure for you.
kzalloc_flex is just a macro over kzalloc(struct_size()). It does not
do automatic __counted_by, which makes no sense.
> -Tony
