Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306473890F3;
	Mon,  7 Sep 2026 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770671; cv=none; b=Ec6G4eddXNpLucOnB42hFmLyf8bUJ2gYsviu9L5DgSNaUBkFdT9CuPXmUxmvK1MhFVZ1OSmEmFZWR6ZKpkPC4+pDvnQq4il29MYWXtS5UMx3nvuhQRHrPg76cSS/Gk0cBhg6bWoPeaiTc3sb3PtBBTffWJwWTyCSAgMNiouXABw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770671; c=relaxed/simple;
	bh=DsWc5EVaT+PvnKDzAlLxXzT9EqWRg2agvFm7VEGk73U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ykl+21V6hcK1yTA14w+zD21iOuq9LSnyQFrM1PzYtFGi4TuIaymVi6G+aoeByX1pXWtJ+3xflncB1/RcF73hUV3bq6phRW7TXsF80xa/Y1HXct6Qrs//GFNk0BNCpMtajxc/K65pARnKvlBVqZZerEEzFiw4CsN1f1HyKmgPZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8ZgtO/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8ZgtO/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D71F00A3A;
	Mon,  7 Sep 2026 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770669;
	bh=3iSfeOt/KWu8SxLaFowWKa5gcqKkQkj8Cb858TjXkuA=;
	h=From:To:Cc:Subject:Date;
	b=f8ZgtO/KVK3CLtBT8iJ6Lo3PTFcYrvOxvfQ1QOZVRUvkA3y2853k9DP+IoRlA64GS
	 KDmeyvxuPvVkdsjj8iuHp/R7o2eAEgdyb46RGBrv6K311f4+Uw1A7Ri1QkcQBpqeUm
	 fG/sTId87q4CxBWXm5CJAqk5svPpWbdZHQFudKbDI5fU5PjA6lAhhrVsNE9eWOAPHd
	 dQclvdC1BSgoBcNjacSaPj5q4SVyC07ieYphKz29MJRnvfN7PxMuagsVMBhMYDYsf7
	 wh1G+1PO1bWUo7WLe6299l7rlnEWDK8wJ5etRCXQxdVnV7hnz54rb+RhOu3iGiNY17
	 FOu3LUyAg14Aw==
From: Thorsten Blum <blum@kernel.org>
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH v2 0/2] Add and use supported/unsupported string helper
Date: Mon,  7 Sep 2026 10:43:19 +0200
Message-ID: <20260907084319.351688-4-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=blum@kernel.org; h=from:subject; bh=DsWc5EVaT+PvnKDzAlLxXzT9EqWRg2agvFm7VEGk73U=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnzKtXjbFj1tVMN7jz/4MS+uGr7o5MJz5/+Ct0/89zMG IHsK4s3dpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEfpxh+MNnxfbU+ufXOQWP 7BSs/h36Mov1XWH1kfpcblvB4J+7Fz9k+O9dsaJslZK0Y8x09/MHdnOvMHrJmbVVemO/0353zY8 PvrMCAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add a shared str_supported_unsupported() helper and use it to replace
thinkpad_acpi's custom implementation.

Changes in v2:
- Add and use str_supported_unsupported() as suggested by Ilpo
- v1: https://lore.kernel.org/r/20260806131549.235170-2-thorsten.blum@linux.dev/

Thorsten Blum (2):
  lib/string_choices: Add str_supported_unsupported() helper
  platform/x86: thinkpad_acpi: Use str_supported_unsupported() helper

 drivers/platform/x86/lenovo/thinkpad_acpi.c | 42 ++++++++-------------
 include/linux/string_choices.h              |  6 +++
 2 files changed, 22 insertions(+), 26 deletions(-)
