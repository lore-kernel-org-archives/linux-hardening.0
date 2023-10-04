Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7B1B27F;
	Wed,  4 Oct 2023 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvBSh8+d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7350DC433C7;
	Wed,  4 Oct 2023 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445096;
	bh=kMdSleGdDSkNeDkcR8NOit5Qc/BamxxI/xtLxfY4N7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvBSh8+d3KS95DWmkQU5S8YVC+ZI3O+PTcEZCLG5tn4cSI9ZlVpg/QlKMjI9qr1af
	 W/UIXvUhfw+qogfjtZypafxFlHUHilDm0Jk9S6tOmvbdgEG2EtDZy8qCoi9EssSORJ
	 lLrVyegmxtJ4obzy8MGR356nWOdRGcW6RPquak3X4gpUNMJPKv8PbWtAn7az9kaiXU
	 UZKnNiQTI/M3AHuyEwqiFIt8+NTFJuf/+oYTlIsbdkxq/lX4ddY/HTZT9PZgk7sRX3
	 PX5Zn8tGWJ5JUQXTvUOuJPQuMmDdxZQrjivfV1eFnCqWUh8HiCeOiYu7cDPZpff5vI
	 b4bzATHFmvxYw==
Date: Wed, 4 Oct 2023 21:44:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
Message-ID: <20231004184452.GF51282@unreal>
References: <20231003231718.work.679-kees@kernel.org>
 <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8p_o5xtmrV+Vm0JUR5VQmMenqtm3xbJuE0TSj-_4Bthfw@mail.gmail.com>

On Tue, Oct 03, 2023 at 04:21:05PM -0700, Justin Stitt wrote:
> On Tue, Oct 3, 2023 at 4:17 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> > array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.
> >
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-rdma@vger.kernel.org
> > Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
