Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9069918F2EB;
	Mon, 17 Jun 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658172; cv=none; b=ZIIyU8ZjffDYGRdtcmGHXPVsuWOZ5n9Hry2vKalKNkW3QSzZdNQCr9EEz6islFBLTfzNhBWJlAP1crw7IopXbHS0kndwz00X/E+bL+D6vA0WcAqC6fE6C+FFNZUCGo2yUrgwpOJ62BjwtyeRcABSLTSO8U8455QmkWVKL5S5tBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658172; c=relaxed/simple;
	bh=FDxCfT8MR8IcCEXkZo51B6b6FGC7jCvlc1c7rTFSmyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzMXCLlXjvkNw3my8soObvPnnAiw4E3M5+iWtGQD2BIkVMs73ZNxzmeE24SzzaU1rTtVOnojj79jslnpgsYMN6M85tLmRK8mWFBmuDybVqENxXDxBvXslvUtLPaHqP+05Kg8Wy4RzGhDw781QmkkyyKy7GquaHu93lgdxOOKHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6P9/SMe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6P9/SMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A411C2BD10;
	Mon, 17 Jun 2024 21:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718658172;
	bh=FDxCfT8MR8IcCEXkZo51B6b6FGC7jCvlc1c7rTFSmyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y6P9/SMeXyb1oYIdYDJUi+EGhxL5Um4xMKdXcqPkOn9IsfF8MbNy8CFCKAh5Bic8Y
	 blt3TUQk1We6QQKO+670rdDr01w3NXdzMtYjgogalcjwH6N1LIUncvFtQq7WUWS7BS
	 gzZPb90Es4dmlUMfAeED6TN5d7q0Qi0KqeqYoU7RvErLbAZFfNfXXnyqqOOAz9W7XE
	 Ta1Va9K/wJ/2dAAHTB/bw3DXm4yLdr6KDMkWOxrKIaxZTOVYaxy9ZERf2doYBYzWfl
	 2XKiSkaOdk1YyA4utLCjPIlH17JG8XaxdvB0Dx1NWoOi6j9v7HNt6qTLpT72aylIpD
	 eUdeWRdtEDxgA==
Date: Mon, 17 Jun 2024 14:02:51 -0700
From: Kees Cook <kees@kernel.org>
To: Tom Rix <trix@redhat.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, mhiramat@kernel.org,
	akpm@linux-foundation.org, ndesaulniers@google.com,
	masahiroy@kernel.org, paulmck@kernel.org, hannes@cmpxchg.org,
	ojeda@kernel.org, thunder.leizhen@huawei.com,
	christophe.leroy@csgroup.eu, vbabka@suse.cz,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] init/Kconfig: extend -Wno-array-bounds to gcc 13
Message-ID: <202406171348.8D43518308@keescook>
References: <20230306220947.1982272-1-trix@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306220947.1982272-1-trix@redhat.com>

*thread necromancy*

On Mon, Mar 06, 2023 at 05:09:47PM -0500, Tom Rix wrote:
> With gcc 13.0.1 on x86, there are several false positives like
> 
> drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:167:31:
>   error: array subscript 4 is above array bounds of ‘const struct sparx5_psfp_gce[4]’ [-Werror=array-bounds=]
>   167 |                 gce = &sg->gce[i];
>       |                        ~~~~~~~^~~
> In file included from drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c:8:
> drivers/net/ethernet/microchip/sparx5/sparx5_main.h:506:32: note: while referencing ‘gce’
>   506 |         struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
>       |                                ^~~
> 
> The code lines for the reported problem
> 	/* For each scheduling entry */
> 	for (i = 0; i < sg->num_entries; i++) {
> 		gce = &sg->gce[i];
> 
> i is bounded by num_entries, which is set in sparx5_tc_flower.c
> 	if (act->gate.num_entries >= SPX5_PSFP_GCE_CNT) {
> 		NL_SET_ERR_MSG_MOD(extack, "Invalid number of gate entries");
> 		return -EINVAL;
> 	}
> ..
> 	sg->num_entries = act->gate.num_entries;
> 
> So disable array-bounds as was done on gcc 11 and 12

So, as it turns out, after much discussion with GCC devs (and Qing's great
patience with me), I finally see that this is not a false positive. GCC
correctly sees a test for "i >= SPX5_PSFP_GCE_CNT", hidden away in the
macros and inlines, and is reporting "Look, you have an execution path
where i is out of bounds."

(It is not a result of the shift sanitizer nor the array bounds sanitizer
-- I was convinced these were responsible, but I was wrong.)

Here are the details:


"gce" is this array of size 4:

struct sparx5_psfp_sg {
	...
        u32 num_entries;            /* PSFPAdminControlListLength */
        struct sparx5_psfp_gce gce[SPX5_PSFP_GCE_CNT];
};

#define SPX5_PSFP_GCE_CNT 4

with the loop:

        for (i = 0; i < sg->num_entries; i++) {
                gce = &sg->gce[i];
		...
                spx5_wr(ANA_AC_SG_GCL_GS_CONFIG_IPS_SET(ips) |
                        ANA_AC_SG_GCL_GS_CONFIG_GATE_STATE_SET(gce->gate_state),
                        sparx5, ANA_AC_SG_GCL_GS_CONFIG(i));

That last macro is:

#define ANA_AC_SG_GCL_GS_CONFIG(r) __REG(TARGET_ANA_AC,\
                                        0, 1, 851584, 0, 1, 128, 0, r, 4, 4)

Note the "r, 4", which is actually "i, 4". These are passed into
spx5_wr() as rinst and rcnt respectively:

static inline void spx5_wr(u32 val, struct sparx5 *sparx5,
                           int id, int tinst, int tcnt,
                           int gbase, int ginst, int gcnt, int gwidth,
                           int raddr, int rinst, int rcnt, int rwidth)
{
        writel(val, spx5_addr(sparx5->regs, id, tinst, tcnt,
                              gbase, ginst, gcnt, gwidth,
                              raddr, rinst, rcnt, rwidth));
}

and spx5_addr() does:

static inline void __iomem *spx5_addr(void __iomem *base[],
                                      int id, int tinst, int tcnt,
                                      int gbase, int ginst,
                                      int gcnt, int gwidth,
                                      int raddr, int rinst,
                                      int rcnt, int rwidth)
{
	...
        WARN_ON((rinst) >= rcnt);


It is specifically checking for "i >= 4", and GCC is correctly reporting
that this is therefore a reachable path.

So, the correct fix here is to do the check up front and make sure an
invalid array indexing cannot happen:

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 8dee1ab1fa75..23c40b9b74d5 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -163,7 +163,7 @@ static int sparx5_psfp_sg_set(struct sparx5 *sparx5, u32 id,
 	spx5_wr(sg->cycletimeext, sparx5, ANA_AC_SG_CONFIG_REG_5);
 
 	/* For each scheduling entry */
-	for (i = 0; i < sg->num_entries; i++) {
+	for (i = 0; i < ARRAY_SIZE(sg->gce) && i < sg->num_entries; i++) {
 		gce = &sg->gce[i];
 		ips = sparx5_psfp_ipv_to_ips(gce->ipv);
 		/* hardware needs TimeInterval to be cumulative */

Or, if you want to retain the WARN:


diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
index 8dee1ab1fa75..5ffeb299fcb4 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_psfp.c
@@ -164,6 +164,8 @@ static int sparx5_psfp_sg_set(struct sparx5 *sparx5, u32 id,
 
 	/* For each scheduling entry */
 	for (i = 0; i < sg->num_entries; i++) {
+		if (WARN_ON_ONCE(i >= ARRAY_SIZE(sg->gce)))
+			break;
 		gce = &sg->gce[i];
 		ips = sparx5_psfp_ipv_to_ips(gce->ipv);
 		/* hardware needs TimeInterval to be cumulative */


-- 
Kees Cook
