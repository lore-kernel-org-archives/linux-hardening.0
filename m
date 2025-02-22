Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF385383;
	Sat, 22 Feb 2025 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740185534; cv=none; b=E/PvmA/UWBxpbF6h2ZlDyyQPuldsxAahOR1LrnWDmQKLliAwIOTiIlczsvIx/JTUpBSuewTuYkDRihgzVn4GrSa3LNMqfUBJlFtCw+LdCvseBVyuNmTVGEBIVMTV6dIouTsUADFAC7W8KIbryUvZeAs5EFuk3k8kuOajSIb1wuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740185534; c=relaxed/simple;
	bh=p3Z3OV/D1L8Z9Gx0KgTb3RoA/MWjnp5ufzpx82ZXlAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDRQ2dw0SbIbb60hDAn0O//L5+Zk92zAtAx8BPRJAb4hz70jmK2lPg+NcRPzlNXVcmQuutyeRmuy6FYFH4/1U8CuCUmWCk/vlTakC8axe41o6qFcB0Iy4EKtM+PRw79ofXH3YXqJKRFwncjcsKMsKS32jLSJnUPocp/jjEuHpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/4zBEGc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/4zBEGc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFBAC4CED6;
	Sat, 22 Feb 2025 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740185533;
	bh=p3Z3OV/D1L8Z9Gx0KgTb3RoA/MWjnp5ufzpx82ZXlAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p/4zBEGccczupXg+ewnuC2hmKWM51kfTF8QiA4iFGnRal5FHNFJqV8wMSXJ18KAtw
	 tn33Agh3zexCGhuX3CsOPomkhn0VwSKAz0YU4rdubFJmHbTo2wK0LA0jAPvVgOMIh4
	 pawPurfCNhx1I2mHL75wLEeDgSprjbrf6wsg/KBTIZVjqlYxN7orliHxhPqi+hf2Mn
	 eQTYsRpi8qn6kgn8WqurZ11sNWX1S1FUDyglLOjPMK3aVJOIwtPkD2TGS6KQAr3glL
	 oCWclS46Owqda/sRAEd4SAz9KxvnUg7l7Lxjii5OZ0KaVt5oZjQjBWJzgN5wxZE1hB
	 Q3XF8ExgcWUxw==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entries in FORTIFY_SOURCE and KERNEL HARDENING
Date: Fri, 21 Feb 2025 16:52:08 -0800
Message-Id: <174018552604.3367606.18022424280657472316.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217100643.20182-1-lukas.bulwahn@redhat.com>
References: <20250217100643.20182-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Feb 2025 11:06:43 +0100, Lukas Bulwahn wrote:
> Commit db6fe4d61ece ("lib: Move KUnit tests into tests/ subdirectory") adds
> a file entry to the non-existing file scripts/test_fortify.sh. Probably,
> this entry intends to refer to ./lib/test_fortify/test_fortify.sh, though.
> As that file is already covered by the entry lib/test_fortify/*, there is
> no need for a separate file entry. So, drop the unnecessary file entry to
> the test_fortify script.
> 
> [...]

Applied to for-next/move-kunit-tests, thanks!

[1/1] MAINTAINERS: adjust entries in FORTIFY_SOURCE and KERNEL HARDENING
      https://git.kernel.org/kees/c/ee0445d6b6e9

Take care,

-- 
Kees Cook

