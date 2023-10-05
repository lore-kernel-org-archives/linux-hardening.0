Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752936B1E;
	Thu,  5 Oct 2023 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNfm48lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05CC433C7;
	Thu,  5 Oct 2023 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696524764;
	bh=MgFWaWNx9i/xDOOSQ9MpMUgMmqSc1reTXGh7sUetAUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNfm48lPKFk4SywQqYaqYcII1gJDK81NxrWN29C2L9Z1vr4lu5Uzzl1pWCSJI+VOB
	 VPH4ztGOHA9Gt4nfo0k0xg9ejrC+pPq/4QQjXQZ4mYT90S8XBxrJ06DrWZrLXOreXy
	 WCG8PMykRR3/lSQxA65BEcF/9oaQRdT4i8A/KBvELObtjC/n8gUff0AqydoDujBqew
	 u2bbKnaH+7O57LPXEc1dB01sKJMvCf4n38LAZzYsVGSn5+G4lb27hbZZvDDGrLnKTe
	 vkAhat+pspxwFBTM49pfQa0Mg0UnMqXtLUEdtI37isa6+7kKUXFus+Lxp+3MpdHFo9
	 k23e7jNpA5yDw==
Date: Thu, 5 Oct 2023 10:52:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Message-ID: <ZR7p01KL3546e2mr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231005161408.it.584-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005161408.it.584-kees@kernel.org>

Thanks, applied to nvme-6.7.
