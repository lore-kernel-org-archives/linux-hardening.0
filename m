Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C41DCB0D;
	Wed,  6 Nov 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886186; cv=none; b=MzUFL+nW5pODQNEgg9q15F7Cy/+AimcWOf3/jp5kSCP3HUSjpLnUyoNT68DmHjlbPJkBeko9w7fPSSoLk41iCXZ1jbOW9Fa1mIUgWhsadexx2aITl38xMhLqmuaxQi5GQMoyHWXf5bP1Snso4UhgR68jqBDVZJZzmOpHrYBZ8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886186; c=relaxed/simple;
	bh=LqDtCaf6sT8Ul0pzrf9sK08uH+kCq9d0G0LPwtKU58s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXwQwlJB+v4sPasUDSX9mmUt57+HtDokQmz0vS+YJeBh00+vcwAnnGaSSJvJPqN/71I/uDy15cqS8exzEsRAcSn78o3hC4aRCVhCbcqE6TvVBz1yTlDCmSboNTyUODui0uBsq9KcsO08Hyyybj1uQYfRTdE7Z9t6DEmivl9SgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJK6rSuJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJK6rSuJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C40C4CED3;
	Wed,  6 Nov 2024 09:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730886186;
	bh=LqDtCaf6sT8Ul0pzrf9sK08uH+kCq9d0G0LPwtKU58s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJK6rSuJmhyrEylgy/xRh1WvXJEwwu6Qc12bUOq99FAS2c/4yILcrPq/K9Q4Lgcpy
	 mKMLJmXVy/Ruyo8cUkxBCj9Wochf7Hln/xc7/Oli02ZjK9HaWwcL2x04umAG52dnUk
	 oI9Q/2NoMDvqvaHN5HiC79jESLNf2vbidUeCdxvdnJTaRrKetpQuDKyuLt7/Mv0Jlu
	 Q72xtEPxC92PN0c1jhQGqpEwS79Q0oStog7N4dEoDTVqL6qfAHOvdRrkLi31GGO8nW
	 pRz23e8BTt01/w0KVqYcepV0xAacGaAsRl9QAcZpiA421v/ZrV77sOKF27luOcS9a/
	 1+JSGOh9YWQrA==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: Replace one-element array with flexible array member
Date: Wed,  6 Nov 2024 10:42:51 +0100
Message-ID: <20241106-bauaufsicht-liberal-74a434043a7a@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103121707.102838-3-thorsten.blum@linux.dev>
References: <20241103121707.102838-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=brauner@kernel.org; h=from:subject:message-id; bh=LqDtCaf6sT8Ul0pzrf9sK08uH+kCq9d0G0LPwtKU58s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRrWyktf/Lyor24sLtmPIPok10hPFliYt+Pi7LyPP0vv 8mocbNpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETytBj+Gf7Iv8cdY5H6x+H5 1kKF156/Duc/L1/9LT01LcclcUPRX0aGrw8PKE5VXvCeI98rb8LCimR3zoc+DA/nRRvdblvMb1/ LDQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 03 Nov 2024 13:17:09 +0100, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct vxfs_dirblk.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] freevxfs: Replace one-element array with flexible array member
      https://git.kernel.org/vfs/vfs/c/fdfa4c02e6dd
