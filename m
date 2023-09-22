Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C01EA7E
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2354AC433C8;
	Fri, 22 Sep 2023 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695378586;
	bh=yCG8IrY/FuMkm2ycosgLTn3iZcJWMJut0cHXk4vlD18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QCaGTzumTtxgWS+3CspI74lb4Jg+NBi/AMbcMSurCW/MFab8No3HgZRcBFAJj8i4r
	 +mCxJ8KQ9nEZo5EjiHqkFSrzWDuSM8PNn/z0peVt7XUn1MhgubcUuTcPvHDKU2EzoQ
	 byP34bIYM9bgEXYMbgfryHyvLv1OREjcU6TJommYnox7oNPFgBzeC3MgIARtCgLFe3
	 1yQVhThkAlrNI4o+Y2E7fUtjtcYs9fzsqFOETDDJFiXftNprEoFzF7YFaHHEwRg0bF
	 3fFjYqxMj6sucPiSHmwp6UoQbypHXAswYIj2OaYhEVPtyjXdSIKnuK+f+17iVx1VNj
	 xanmOFVHvgNVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Mustafa Ismail <mustafa.ismail@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Justin Stitt <justinstitt@google.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-irdma-i40iw?=
 =?utf-8?q?=5Fif-c-v1-1-22d87aef7186=40google=2Ecom=3E?=
References: =?utf-8?q?=3C20230921-strncpy-drivers-infiniband-hw-irdma-i40iw?=
 =?utf-8?q?=5Fif-c-v1-1-22d87aef7186=40google=2Ecom=3E?=
Subject: Re: [PATCH] RDMA/irdma: replace deprecated strncpy
Message-Id: <169537858200.3339131.1210100374034113927.b4-ty@kernel.org>
Date: Fri, 22 Sep 2023 13:29:42 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 21 Sep 2023 07:36:26 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]
> and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer.
> 
> [...]

Applied, thanks!

[1/1] RDMA/irdma: replace deprecated strncpy
      https://git.kernel.org/rdma/rdma/c/f0cc82ca116f5b

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
