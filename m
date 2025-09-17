Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD04086A;
	Wed, 17 Sep 2025 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115549; cv=none; b=tiwVuhZtP48iLW11Y3nmHfICT+Nn9gVmzvM9at5zRd8K2OTCDaeYEdAtQ8Or8PcsOcE4FiDkHY5ves9kEXgTYo7lao/6c/tX/deYrY6Uay3eCsCwG9kVSj8Vm3gwWA/2dzlNwotZTEXCY3r6MXu2qXcZn2dok1X/Eqh+DKarrys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115549; c=relaxed/simple;
	bh=oQsiOAAwXPKVTRPEdd7R4V3CfL66QEI5EThA/cQWxbA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s8cJtWs1k/GNqa/KoqvVnmiPxJ+ZjGRBI9LDZM2Uxhd0ggza7uAvVkNUFBOC0DdeSFPmaa4ySJE8nl7qIPEdKSZiVwfOyW5GKPo3Lr80LlvyGcxi3QrJsPTB5iMDupsR++4xKjrSs1FLV7b5CSobX7RBPCBKdslvf+DyR0i4wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw2xViJ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw2xViJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3351C4CEF5;
	Wed, 17 Sep 2025 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758115549;
	bh=oQsiOAAwXPKVTRPEdd7R4V3CfL66QEI5EThA/cQWxbA=;
	h=Date:From:To:Cc:Subject:From;
	b=Rw2xViJ6Po0IymGMP2y5IpODMIpD9MiRzQtZLG6+Wga5B5meo0V3l/tU6VCJaHDql
	 JNJ9ByqmJUM0IyqCVPAjAdR8Q+3R/bS+lTJuE33FC/Hp+7zAW/EMoP4xFz8BPFZ62l
	 a72DNjgaJ7MjxOIv8tUHHw2Q3hiSwWXDErB/UI2Qbsa/INUKla9TnPK5LjD9iPQXxV
	 ECveJ3412Pz1NId5WCyKyqldqokMA1j60grw16m4oqgeQUvLF0ndbe81YY9IJwU1oU
	 g2Z87RUn6li0o879b/fV80jHSAvNPi5Y1NGGuJMGDiv1J8X1/9pPQcUgpQb6EUVued
	 hN8c5ag+qE8Rw==
Date: Wed, 17 Sep 2025 15:25:44 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 0/2][next] Expand TRAILING_OVERLAP() capabilities
Message-ID: <cover.1758115257.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Small series aimed at expanding TRAILING_OVERLAP() capabilities.

Gustavo A. R. Silva (2):
  stddef: Remove token-pasting in TRAILING_OVERLAP()
  stddef: Introduce __TRAILING_OVERLAP()

 include/linux/stddef.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0

