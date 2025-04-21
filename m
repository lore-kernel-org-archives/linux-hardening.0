Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAA721ABDC;
	Mon, 21 Apr 2025 21:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272719; cv=none; b=kMmdaOnWkl3/AixKgVt/0WRvPOxfD36EccVIpoJg79nSorojKJZ3eJ/Be3WGEwNPd0Mfl0qLA6D5mgZxXXz7pN5mOF8CYGSNDEvhZEeKdXCcYS0Xz93GZJMgJhu0mL+sM1UpmGd7CauCQ+6xNFQbX2X+10QZb8Tz6ywnRwZNI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272719; c=relaxed/simple;
	bh=jTKO/ZVih+JbltPyJqGvHcdaODnrapZSlfJDyMxef4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M/s9MjIa2tezRY+fXsHEOq4lTUNORMvm2Ebxguib13zd7pHhbQwT5yijZEcuRbYPkk+YoQJ/NCrpX9+RasX4eiTHNn8PXsiJPsG5ntjREDRCRu/SdTRH270HXRW81leCe7KMJ5zXLMBHAgnRsaxl40QU7GwdUZM3is7mmzSiN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFtgHgPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFtgHgPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE7C4CEE4;
	Mon, 21 Apr 2025 21:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272719;
	bh=jTKO/ZVih+JbltPyJqGvHcdaODnrapZSlfJDyMxef4Y=;
	h=From:To:Cc:Subject:Date:From;
	b=fFtgHgPGy3B/E/XUe25ID7SWmNeqPWBZxkCVdbHHYL+A51fXREBW8icOwy2DQ1PGZ
	 smwFCDE95c6RimcL1YJg9aTDuUYltW33fZi9YMbmACjVwDjG1z/PAFzPST6qh01MnH
	 9KJSw7OSA6E9BHLHw176HqTRC4XPgsDEIMZuXyGRPFfOSmsgg6pEqS/z4I5JiAvYNr
	 ALH/HpWab/u82LXnJcB/8M/YqWo/ANNAuKYDerSBBuD6gQBtYA/ubzdJWSfczHdRIS
	 7wM4umVvzxVlGqeqvyjSTgjjbS9aqm1I7po1F3gwmV6MCpIxTwvLmyidAoekEfb/Xw
	 lKL/3oJrWjufw==
From: Kees Cook <kees@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jesse Zhang <jesse.zhang@amd.com>,
	Tim Huang <Tim.Huang@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Alexander Richards <electrodeyt@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/amdgpu/atom: Work around vbios NULL offset false positive
Date: Mon, 21 Apr 2025 14:58:34 -0700
Message-Id: <20250421215833.work.924-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2865; i=kees@kernel.org; h=from:subject:message-id; bh=jTKO/ZVih+JbltPyJqGvHcdaODnrapZSlfJDyMxef4Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBls+zvvHM+YreCqfKrQev31s18a+6e/XrJg684vsbzLU 48ZvEp82VHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRDQEMPxkXbGaK6YjXLGtc O/0tz4G3f7gCeBMVuF2kjIJqT2+zt2T47+lbZ/C35qeel/qk3j0vTpQrS/tNEXbtmxJf8EMws6S BFwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC really does not want to consider NULL (or near-NULL) addresses as
valid, so calculations based off of NULL end up getting range-tracked into
being an offset wthin a 0 byte array. It gets especially mad about this:

                if (vbios_str == NULL)
                        vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
	...
        if (vbios_str != NULL && *vbios_str == 0)
                vbios_str++;

It sees this as being "sizeof(BIOS_ATOM_PREFIX) - 1" byte offset from
NULL, when building with -Warray-bounds (and the coming
-fdiagnostic-details flag):

In function 'atom_get_vbios_pn',
    inlined from 'amdgpu_atom_parse' at drivers/gpu/drm/amd/amdgpu/atom.c:1553:2:
drivers/gpu/drm/amd/amdgpu/atom.c:1447:34: error: array subscript 0 is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
 1447 |         if (vbios_str != NULL && *vbios_str == 0)
      |                                  ^~~~~~~~~~
  'amdgpu_atom_parse': events 1-2
 1444 |                 if (vbios_str == NULL)
      |                    ^
      |                    |
      |                    (1) when the condition is evaluated to true
......
 1447 |         if (vbios_str != NULL && *vbios_str == 0)
      |                                  ~~~~~~~~~~
      |                                  |
      |                                  (2) out of array bounds here
In function 'amdgpu_atom_parse':
cc1: note: source object is likely at address zero

As there isn't a sane way to convince it otherwise, hide vbios_str from
GCC's optimizer to avoid the warning so we can get closer to enabling
-Warray-bounds globally.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Xinhui Pan <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Cc: Tim Huang <Tim.Huang@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alexander Richards <electrodeyt@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 81d195d366ce..427b073de2fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1444,6 +1444,7 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 		if (vbios_str == NULL)
 			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
 	}
+	OPTIMIZER_HIDE_VAR(vbios_str);
 	if (vbios_str != NULL && *vbios_str == 0)
 		vbios_str++;
 
-- 
2.34.1

