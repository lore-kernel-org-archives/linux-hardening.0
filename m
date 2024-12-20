Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F21A072C;
	Fri, 20 Dec 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714548; cv=none; b=RjW11wp96P3eemmF8Ttl94PGzA5PpfA6H8FpoukHIMYlk7k8Qt07qFVu6JWnkvxs2aPXlkCDigrEEKNYf1Dkg1O8vsDEyxWsQ9qt1fBR5DcrcGb/IU7/ZExRXGYdNmWUA23ulr3/S4igM7+VCivx73pNHMlGPwKcpKML88hqf/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714548; c=relaxed/simple;
	bh=KrZDBpSUHxSNUc07r+o9cYVpnZHoq3YyAKJ9qB12/NU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYUMztMcm7FoM/TTn0li0v8P15oVEc5f6XeLco3RZCQ/5pVhyDp/t44NbD9BKzZH3n30vS7re1E6XqCFLkl7YdbBzRpjgKNTZZA3SZIWiu+N3yrNJtk27ni8ppqtetYDNtXvl6Rgn8wFvyp4zfOtDe6ndnJ3ukEMRPuKXcD+864=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwz2o0Kl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwz2o0Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C80C4CECD;
	Fri, 20 Dec 2024 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714548;
	bh=KrZDBpSUHxSNUc07r+o9cYVpnZHoq3YyAKJ9qB12/NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwz2o0Klh9P3xt9f5d7hNz38TUO88R24qpdYj4gSFFr59JsRKig35mxbqRNfSB8Bm
	 VfYn+cRryNf2Dcn0ynqpiI5Y9xDMHo36qRJPMr5FpjSSnZK+jycSwGoZUdGC2/31ji
	 uBzysnq+AfIBvxXafuM9x/ELc2k3O4Sc7icK9+NK6pxUJCRbIRObImIXg0xmIpuVpn
	 FeDsDJLIqXIIH7lXQoO+2O9d4tDpx2vRQW37rKWj9g6qKmptuFA4ZJgVSZ1tPAULhU
	 9YJWJbtqIoeUQvg5Gvy8XNw8+ay9hGVuv8dH8SX8FUy17WsGLR5uKuzZib2guXJm11
	 /BLIaDeC5UUVw==
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Christopher Ferris <cferris@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Keith Packard <keithp@keithp.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] stddef: make __struct_group() UAPI C++-friendly
Date: Fri, 20 Dec 2024 09:09:02 -0800
Message-Id: <173471453998.1198562.7846004024566721255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219135734.2130002-1-aleksander.lobakin@intel.com>
References: <20241219135734.2130002-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Dec 2024 14:57:34 +0100, Alexander Lobakin wrote:
> For the most part of the C++ history, it couldn't have type
> declarations inside anonymous unions for different reasons. At the
> same time, __struct_group() relies on the latters, so when the @TAG
> argument is not empty, C++ code doesn't want to build (even under
> `extern "C"`):
> 
> ../linux/include/uapi/linux/pkt_cls.h:25:24: error:
> 'struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,' invalid;
> an anonymous union may only have public non-static data members
> [-fpermissive]
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] stddef: make __struct_group() UAPI C++-friendly
      https://git.kernel.org/kees/c/724c6ce38bba

Take care,

-- 
Kees Cook

