Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DAD2D46D1
	for <linux-hardening@vger.kernel.org>; Tue, 26 Aug 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227296; cv=none; b=FwQqEKzsky+j3vT7mue2mnujzst4xu8cZY9ZbaTIpST9jDAG9OA+WF9DUfLvv0YZzyTdG9dx4PFfC6zeUtUx0e1WrsswdAD6C2zYgEkrlIONiOwTEoc73CaTlK+6Y7XlXPOYRCyNlODdPKb6seNgwSJRhJjc69wAcA1T3TxbBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227296; c=relaxed/simple;
	bh=R8FCR1pAG7JUS5yb+f40rtndsJPEalxMOWYd2GENzAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBU0XYLed1ObsGnufyQ/M93sGOQb8haZM8BG+RTssr7JN/U698mZeUNIWd5llhjBM0l1dPxSBNRkbIP/bGpv1rrPYx6pHgXuAWzzFiUqdXQQsVSUBg9GbL6ZpdkVGabq1myawSZp8LwsaSRJ64zHNDXdMNmr+vpmPr53F/ctRo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Ec1Uxj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Ec1Uxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E03BC113D0;
	Tue, 26 Aug 2025 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756227295;
	bh=R8FCR1pAG7JUS5yb+f40rtndsJPEalxMOWYd2GENzAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2Ec1Uxjt634ml5/hFNiSKSqxwBs4YAsn8Dp+ejJkWbnWrH0CjkQSaMO1idpYwmWO
	 TynODyw5uhEjc7W3j7XNBYaV5ltVfxl/aP9GY4grTxzxx0ddZpsiuBU+487BOCgcXc
	 CeDAcnMyR/vumqpYRiaPZEgiKub58fv9ArcsoImVDzBcARpGMgk8BLAHu0kDRcOP5N
	 qSe6mEaV/01ncS7AlbRQ0Cjt58Lb3hYmivsTbB/GbwlOoYJ/g+h8DxUUkbzyGn9zH/
	 tifga5wysedPo59IvWTAaPAekSikZ4zVFv4oznb9dferrN81VFC45eoUIWp4SJO8fK
	 DL906oRoa01Dg==
Date: Tue, 26 Aug 2025 09:54:55 -0700
From: Kees Cook <kees@kernel.org>
To: Claudiu Zissulescu-Ianculescu <claudiu.zissulescu-ianculescu@oracle.com>
Cc: Andrew Pinski <andrew.pinski@oss.qualcomm.com>,
	Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Fix sanitizer attribute infrastructure to use
 standard TREE_LIST format [PR113264]
Message-ID: <202508260954.69357B7F27@keescook>
References: <20250826061735.it.634-kees@kernel.org>
 <acc8a12f-e9c3-4c1d-9e7f-9dd9be473292@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc8a12f-e9c3-4c1d-9e7f-9dd9be473292@oracle.com>

On Tue, Aug 26, 2025 at 03:54:13PM +0300, Claudiu Zissulescu-Ianculescu wrote:
> I think the tests are missing.

Argh. I will send a v3...

-- 
Kees Cook
