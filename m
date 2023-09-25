Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEA11C8B;
	Mon, 25 Sep 2023 14:28:22 +0000 (UTC)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AD8FC;
	Mon, 25 Sep 2023 07:28:20 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PERtRa100982;
	Mon, 25 Sep 2023 09:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1695652075;
	bh=kiIE/cuC2sOtvlWX64aG3nF6nKMN73VRz8KekUZdOYQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=JUe7AiMUo2yByN6iefSA1twMjHVoU9UHnpQVAW7ZJRQTighFC/ZmpfF3Sh+37uW9Z
	 d3J7lcVRJnnlu1+8coZjbLaDi+Fr8M6wvyLXr+9dxxEgIZJWjHQGqHOEwHIA1NOAnv
	 Lu7BlRIgXP0lEEnkzJ0pPfSwkJyBgXjOP8MS/ZAQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PERtSl002275
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Sep 2023 09:27:55 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 09:27:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 09:27:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PERsLG051392;
	Mon, 25 Sep 2023 09:27:54 -0500
Date: Mon, 25 Sep 2023 09:27:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <upstream@lists.phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops
 reg
Message-ID: <20230925142754.vzvk6o2jncecaphv@whiny>
References: <20230925140710.478027-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925140710.478027-1-w.egorov@phytec.de>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16:07-20230925, Wadim Egorov wrote:
> Seems like the address value of the reg property was mistyped.
> Update reg to 0x9ca00000 to match node's definition.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

Missing:

Fixes: f5a731f0787f ("arm64: dts: ti: Add k3-am625-beagleplay")

With that:

Reviewed-by: Nishanth Menon <nm@ti.com>

> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index 7cfdf562b53b..2de74428a8bd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -58,7 +58,7 @@ reserved-memory {
>  
>  		ramoops: ramoops@9ca00000 {
>  			compatible = "ramoops";
> -			reg = <0x00 0x9c700000 0x00 0x00100000>;
> +			reg = <0x00 0x9ca00000 0x00 0x00100000>;
>  			record-size = <0x8000>;
>  			console-size = <0x8000>;
>  			ftrace-size = <0x00>;
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
