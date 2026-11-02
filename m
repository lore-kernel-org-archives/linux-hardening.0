Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628852;
	b=cuKoR4PVdFQ4K2ajWzeM4MmxFbdOxcqK9pvEOrFVtegwzT1hyffZdE4fDnezSOsdZJAg
	 o7TRI11KEEzkPBZbzNqYN4tqCOGC4jlbO0i8b48At2zTEkS/22hKy4QBkRyPPLJISDWFU
	 DZrCJ3Ua4bySkGWfs2ZBGcASyCuflljDhWSekCxIdhXu1m9x4YxvZQpyTDjbKPVHP5gex
	 CjVBACOCWJ3ZO9voXxwYBEJMBEWTSu8KvDWip0d8t//aMzWY4TtnJW+LHKZ34lB9ejXja
	 7rc4cRgFHee3I6Ef4a76ePi/ZoGsiCseDnFZ1MVP9gYR2p1Yk9BXQ2MQoDpTvQoMehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628852;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=b54Isd4z7HUSwzET7l6EJGjGARdRgfUq9X9wGohjWZk=;
	b=4MtZ1Z6v6v8Mg5GzD12RS3cmJELYKZW3naktMJOdp2e+QY5JP44vv9GQU5j7wGGXBL7M
	 FdrbI7mCYKLD4WlXNcEmxGLBY6Tv/Zq+FKfd9dKGfmN2PhEo6DvwzUhnCV0y4ovZQqu1m
	 Zvj0SrLRBTIGrdCcK8RTc3umXlMvFsMYEvQ57JNfV2PJk/URiXNHM/pOinkBXdvPl3Ix4
	 ESZeemZuOg5giAALM7y1FKb4mYpM9BB/V6nFcgyB9GmvL6f8sSC+wAUdJKLkQOKvfigRf
	 9ZPbYsbe/Ps8GLZONc4zt4uDk3DghZzmTLEozd3itZpRpzsCDXrNukvKBRSFfNGHbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmlbT6uT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF860A3801;
	Mon,  2 Nov 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmlbT6uT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039421F00A17;
	Mon,  2 Nov 2026 14:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793628852;
	bh=b54Isd4z7HUSwzET7l6EJGjGARdRgfUq9X9wGohjWZk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dmlbT6uTFil01qFddIyGLjPXVVvzwH/a4loVjk/bCRGYv/aUp3vS7xa6iuwDGNVut
	 6utXDFf3wuLElnhAkNm9/R3V8dZFDSokO9vhFfk2Css8Hx6CGz8RLBMkqHHG1CiozW
	 9CIFiNbXlUP2iqOCFSuwZCdrIwLzMJmguRtIMauHQDVNre0T24/W8458bV6Te4DrnH
	 lesO77GPJJSVqPsyniJM9Y/eLMU/t2/hTWF7jhHZkQQ95n8nsuOhrRRiSsNq9R8F9X
	 TFxIJqeTlZ2ZHPx+zPl4xdpkXq5LGvqM1EtVXhRBSuG/h7+9D46ISs/VUHC2wmQVlE
	 E16DQ3838vsZw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 1DC722377C4C;
	Mon, 02 Nov 2026 14:14:10 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Thorsten Blum <blum@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20261102113019.265822-2-blum@kernel.org>
References: <20261102113019.265822-2-blum@kernel.org>
Subject: Re: [PATCH] regmap: Annotate regmap_access_table members with
 __counted_by_ptr()
Message-Id: <179361979450.1776482.7254109253538340654.b4-ty@b4>
Date: Mon, 02 Nov 2026 11:43:14 +0000
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=broonie@kernel.org;
 h=from:subject:message-id; bh=daJyc7XbiXAY0L0DUTR/SE90cGDcxHdL/UE5BJfixA8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJezNqofsbd96fT96mLurPzTr/JfMPTI5vd5qhi5HZx7
 dRzhUZsHaUsDGJcDLJiiixxWdwv60ter+E7uLANZg4rE8gQBi5OAZhIuQAjw9LnHr9iC9ar7e8x
 PTylc2/9i7jrvRX7nj+7t2jzxaUFTScZ/tkmplycGuuzfca9Iv+Z2zbvrfpYN+WvwRflANaTAWx
 3vdgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 02 Nov 2026 12:30:20 +0100, Thorsten Blum wrote:
> regmap: Annotate regmap_access_table members with __counted_by_ptr()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-7.5

Thanks!

[1/1] regmap: Annotate regmap_access_table members with __counted_by_ptr()
      https://git.kernel.org/broonie/regmap/c/acebd8e4f16f

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

