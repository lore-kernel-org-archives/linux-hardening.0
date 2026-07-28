Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFAD44C66B
	for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249046; cv=none; b=noG8u+hnEqvpQ+ZH29UKrvN29HCQ5Uy2qQTQoXzWpZitFQdF2HCYG9GSLRvBJQ8F13KGQE8wNUqB/J8t6RdPYtQpwSCyZwjYX8eI0De2wU9ULwDilVB77g0kg/uImSg+TM2Ubw3cN9veZzaVaN4aSU1zWcmINR+PdTuVQZKs6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249046; c=relaxed/simple;
	bh=nMUD66vXKd3gKHm4PvwhUTfpMRJXNK9FiMak8utaw3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvzRY0v9gQlYKM+fJjeyXSfTUGOVsJLy14JS5xhWI2asJrf7MWzm0w0Wf/wa6ymDlrG7yuyLfzYtbdQShNjzKJ/24ufxUIFLU/McYZKUMjCYOPt5TYg4BoARae3hvV6BlmMPfWkP+RN/tjywV7NBAgKTq3uWhlGN6tHZqCpmV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3GMQA78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3GMQA78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C513F1F01558
	for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785249044;
	bh=3GUXLfzdyYUR+OBqXaq/+u7BsqRzK2Iz4nJOnvUrJrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y3GMQA78fCGVHwRveZWDotCS0NX+lPvO6gcTbwwpC17+xnfhZiIzKX/XGgOX1DEPA
	 Hc1Mm9yJw/iBmXF6nB72+qXEblwoEeZ7zyv1FOjrbBMPNo5q8V7qdPOOl3+mWLF61A
	 r6R6nQ1FhoxSqqRbgP+BUyK3ijINDl/7h8Lt87i7YDRGW4I+VfL0QXRlwWz3G0QOOl
	 V51VfjK9S7MzZhk60Rdt9PjOy0juXnqE+BILgyTqR8iLrU1A2t8TMj3sCiip/LPxre
	 8Atreu2Q3AWB0Dln8P58uUNUruY4JUgHQO+BiwIA8H2j8bEdwpBG+S5P+HOJ7Auajl
	 WhteJ96pQG9vQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15dd4b9132so573385166b.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 Jul 2026 07:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roxa+xpcNWVT4lGRZF0E4Y0Z8Ug5PJAx2nF5Q7LaczqupiuE76LLsExVk4N81zM47+9wKmMG7FcBkd5OWKnu0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpAEJlgkGPQ9Sz0XL4UbC0kD5UpVcslkhS8CGJ9VIc7cOCoOW
	2A6BxX/ol2bPPLNjBdbNJAQASU84QNak2AXBUkzs9SBp0nbE5zoAZ3CXe54+1KJyJBuAUrg0OaB
	wc8/XbHkNjSnPgId8MeQKf+JKkA8R7Q==
X-Received: by 2002:a17:907:9414:b0:c1f:6822:945a with SMTP id
 a640c23a62f3a-c1f7249e8f5mr142111366b.57.1785249043360; Tue, 28 Jul 2026
 07:30:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721-tcsr_qre_0721-v10-0-d2fa68c63b78@oss.qualcomm.com> <178512251610.15997.11111449058382808559.b4-ty@kernel.org>
In-Reply-To: <178512251610.15997.11111449058382808559.b4-ty@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 28 Jul 2026 09:30:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLHb_9qgQAgVfa_mb+zLPPqe5Ze-U9oc6HB9aRZe3cGUA@mail.gmail.com>
X-Gm-Features: AUfX_mxuX8ugJmMU2lsLcjqtuKrFPArIpVB-vqZ_ufPEa1Pluh9A5xkDYZMLj0M
Message-ID: <CAL_JsqLHb_9qgQAgVfa_mb+zLPPqe5Ze-U9oc6HB9aRZe3cGUA@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 0/7] clk: qcom: Add common clkref support and
 migrate Glymur and Mahua
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Taniya Das <taniya.das@oss.qualcomm.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Qiang Yu <qiang.yu@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 10:22=E2=80=AFPM Bjorn Andersson <andersson@kernel.=
org> wrote:
>
>
> On Tue, 21 Jul 2026 22:58:55 -0700, Qiang Yu wrote:
> > This series adds a common clkref_en implementation and converts glymur
> > and mahua to use it, along with the related binding and DTS updates.
> >
> > The PCIe clkref clocks on Glymur and Mahua gate the QREF block which
> > provides reference clocks to the PCIe PHYs. QREF requires LDO supplies
> > and a reference voltage from the refgen block to operate. The refgen
> > block itself requires vdda-refgen_0p9 and vdda-refgen_1p2 LDOs to
> > function.
> >
> > [...]
>
> Applied, thanks!
>
> [1/7] dt-bindings: clock: qcom: Move glymur TCSR to own binding
>       commit: f9cbc4bddb636dd9d446bfba31f58fbceaf09424
> [2/7] dt-bindings: clock: qcom,glymur-tcsr: Add mahua support
>       commit: 0998cf30b0e0d02dbcdfc1f989b745137b21f682
> [3/7] clk: qcom: Add generic clkref_en support
>       commit: 22c70e5732005356a4bc2601e7dcf878aab101e0
> [4/7] clk: qcom: tcsrcc-glymur: Add regulator supplies and migrate to clk=
_ref helper
>       commit: 0753091abc4b480abf76cb40c10fffe2764bfcf7
> [5/7] clk: qcom: tcsrcc-glymur: Add Mahua QREF regulator support
>       commit: 0f87ded5f8398182fbac232f0f287d45baa10d6a

A bunch of new warnings with this series:

      2 (qcom,glymur-tcsr): 'vdda-refgen4-1p2-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-refgen4-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-refgen3-1p2-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-refgen3-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qreftx1-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qreftx0-1p2-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qreftx0-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrx5-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrx4-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrx2-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrx1-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrx0-0p9-supply' is a required propert=
y
      2 (qcom,glymur-tcsr): 'vdda-qrefrpt4-0p9-supply' is a required proper=
ty
      2 (qcom,glymur-tcsr): 'vdda-qrefrpt3-0p9-supply' is a required proper=
ty
      2 (qcom,glymur-tcsr): 'vdda-qrefrpt2-0p9-supply' is a required proper=
ty
      2 (qcom,glymur-tcsr): 'vdda-qrefrpt1-0p9-supply' is a required proper=
ty
      2 (qcom,glymur-tcsr): 'vdda-qrefrpt0-0p9-supply' is a required proper=
ty

Rob
