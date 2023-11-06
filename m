Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816C28E2B
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LruJoUjr"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBB13E
	for <linux-hardening@vger.kernel.org>; Mon,  6 Nov 2023 07:53:40 -0800 (PST)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id 009GrKUhP8Hte01v1rFZdY; Mon, 06 Nov 2023 15:53:39 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 01v0rp0ujOk5S01v0r7pow; Mon, 06 Nov 2023 15:53:38 +0000
X-Authority-Analysis: v=2.4 cv=E+DeGIRl c=1 sm=1 tr=0 ts=65490c02
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8 a=EQy5N3Hs284AOLTsN7YA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eApjHkz6lNxwfvlKIIAPEUFtBUpEc7lCSax6Jlj16Gs=; b=LruJoUjrnxdwykyQx50weks1Ga
	1Z+FG6qRzBa0Gs1n+ljrDX8MKkp2tLPpcJA0YupxHgRfe6y/hZdhU1cTGq6q7wOOKXOKoMFNtdDxF
	Q9uLWpUcW7swAgihl2mfTXnOSbMmO5mC9+geK/AGz+UVhBu+U6uVl2+mj15xusMbWTvq89meydBAs
	iYABVi74WtIR8AG0aynPOvt+YmxeWc5+3YHuCCqDThKS2PpPCdUS2/NaIbrHxLbugpat3nrsldGbD
	HO41RWwfB9zebV9v2BlM6lQFx84FdapK/k1qmoJOzyprWKbbVYDdLvNg0rdR+Ty0gV524O/WS9LUL
	h8EugYSQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60964 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r01uz-0028r1-35;
	Mon, 06 Nov 2023 09:53:38 -0600
Message-ID: <66a8cc44-15fb-457d-bea6-3a67a6a62630@embeddedor.com>
Date: Mon, 6 Nov 2023 09:53:36 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gcc-plugins: randstruct: Only warn about true flexible
 arrays
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, KP Singh <kpsingh@kernel.org>
Cc: linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
References: <20231104204334.work.160-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231104204334.work.160-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r01uz-0028r1-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:60964
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKIFcEb+HG8eiM7LiOoNE5zlC8hgtcxEGR5lkUSbDEBORUyvHRRVVtWDWz6uzyJhKqQ2WM/jctvIMUIPV8eYTTAjQ1YyMVHQ4PfGYVdN8i45Eh7Hma4J
 65Js8w+WZSCw5vppVrMnBynzISHXfN4j4ZMs0caumtadjz0TGak0wbXx+cBRBqdG+jsFwmGHWu1kULy/9AHRI0wVMPPpywrgO5Mxc2QKAfZmecoUVQvNA3Hc



On 11/4/23 14:43, Kees Cook wrote:
> The randstruct GCC plugin tried to discover "fake" flexible arrays
> to issue warnings about them in randomized structs. In the future
> LSM overhead reduction series, it would be legal to have a randomized
> struct with a 1-element array, and this should _not_ be treated as a
> flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
> -fstrict-flex-arrays=3"). Disable the 0-sized and 1-element array
> discovery logic in the plugin, but keep the "true" flexible array check.
> 
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311021532.iBwuZUZ0-lkp@intel.com/
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 366395cab490..910bd21d08f4 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -278,8 +278,6 @@ static bool is_flexible_array(const_tree field)
>   {
>   	const_tree fieldtype;
>   	const_tree typesize;
> -	const_tree elemtype;
> -	const_tree elemsize;
>   
>   	fieldtype = TREE_TYPE(field);
>   	typesize = TYPE_SIZE(fieldtype);
> @@ -287,20 +285,12 @@ static bool is_flexible_array(const_tree field)
>   	if (TREE_CODE(fieldtype) != ARRAY_TYPE)
>   		return false;
>   
> -	elemtype = TREE_TYPE(fieldtype);
> -	elemsize = TYPE_SIZE(elemtype);
> -
>   	/* size of type is represented in bits */
>   
>   	if (typesize == NULL_TREE && TYPE_DOMAIN(fieldtype) != NULL_TREE &&
>   	    TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) == NULL_TREE)
>   		return true;
>   
> -	if (typesize != NULL_TREE &&
> -	    (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
> -	     tree_to_uhwi(typesize) == tree_to_uhwi(elemsize))))
> -		return true;
> -
>   	return false;
>   }
>   
