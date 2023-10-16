Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1002A2D
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tb5eKP64"
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22673101;
	Mon, 16 Oct 2023 00:37:56 -0700 (PDT)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A42BF1A45BC;
	Mon, 16 Oct 2023 09:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697441874;
	bh=iFDKFS21j+PdzHEuBrJScpzUlh6ZN6wATcDa0c2Kovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb5eKP64ylz8V5E5bq3xJiABsjlgXYyijqKJnfE1NvMYLDD2BhZvoSIuDjDi5Rg2u
	 uFcPmKn/3wNO2ld4If1K0I1YN+GKmSu1SGFjUqmQ/h5CAM12O48d5GPVSmAFpMqBh7
	 VpcXxFgLWSt85q/RN7/fLtJ/nxKglm4rfXlq3Uy/erZ2NwbHPjwDQZVE8knNCzNEte
	 hZ5hBVg+8E4uV3hYW1hUlX4Anvb/VzF2YMKsnyYTUAMVwi1d8ENgWItb2QNerFkCTk
	 Dc2/l8DA4YIC5G28+VEgn9/rl7d8sSE+w0X7+TgsFeXwx8W6w+yvmXstzrWn6+2bOx
	 Mn+FUAH8n8S4A==
Date: Mon, 16 Oct 2023 09:37:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSzoUVQINYrYSv8k@8bytes.org>
References: <ZSRFW0yDlDo8+at3@work>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

