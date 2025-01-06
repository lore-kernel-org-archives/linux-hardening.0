Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291C1514F6
	for <linux-hardening@vger.kernel.org>; Mon,  6 Jan 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183105; cv=none; b=YWiuMJsuFXbA6i95SaM6ziJ0t+GYrdJvsCCbHquPxxxrzb+xO3YZkkI+zSi3KL1WOLl4+4XLvsa/qqu/HDNOmJeMYNFzmHKPo4r40BN0gpDuLqZGyPy4AQ+lYnL1w+0bJa0W/fcxRUuVCfbLenNqcBnlQYdBYowF81J8BN18kPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183105; c=relaxed/simple;
	bh=8ifLHMRYzV/BdHndyMnDaMSrSWA0Gu2AeLVzaoW+uTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0qxbL6e6t1pp3PrRXd/Q4NDEF1Uaa/l9cw9S/BXV6EY9ij8YIj/CCerl21Aly2hrcm3ZCrsbN7NOj1kL847JpZMCoc8T/nNdtbKRcR1KTq+MIZDQx7B8B7LtIPpOC9Ic3LJJ2KQOcQbX6UsF4cUZgIOJlXXuspK8/rgLEHsRJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=xQhsJh1m; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="xQhsJh1m"
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YRgXV15mgzNtH;
	Mon,  6 Jan 2025 18:04:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1736183098;
	bh=xnnP5Ge2UVIjVFy75zw34onoBGTBNO+43xM26tZU+Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xQhsJh1mMXToUZchdzlrXYlpcL7+YU2H+jl5e3K36qeO++GrWYS5BASL58ddPyGHs
	 pRl2jfvVFDcx3cv179UdU7aac6PNixKzaSSSl6BpidHYfSMkPF0DZKK4mb32Q9dgfM
	 atc5gub4Li60d+7tJYPg7nDWfmfNlYWuDR7Majug=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YRgXT3KQSzMSh;
	Mon,  6 Jan 2025 18:04:57 +0100 (CET)
Date: Mon, 6 Jan 2025 18:04:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, James Morris <jamorris@linux.microsoft.com>, 
	Jann Horn <jannh@google.com>
Subject: Re: security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing
 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset
 -2147483648
Message-ID: <20250106.uu8as0Ha6pof@digikod.net>
References: <202501040747.S3LYfvYq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202501040747.S3LYfvYq-lkp@intel.com>
X-Infomaniak-Routing: alpha

I guess the GCC warning is a false positive?
See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116494

On Sat, Jan 04, 2025 at 07:26:27AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
> commit: ae271c1b14de343b888e77f74f640e3dcbdeb4c9 landlock: Add ruleset and domain management
> date:   3 years, 8 months ago
> config: csky-randconfig-r026-20230729 (https://download.01.org/0day-ci/archive/20250104/202501040747.S3LYfvYq-lkp@intel.com/config)
> compiler: csky-linux-gcc (GCC) 12.4.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250104/202501040747.S3LYfvYq-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202501040747.S3LYfvYq-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    security/landlock/ruleset.c: In function 'create_rule':
> >> security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
>       96 |         memcpy(new_rule->layers, layers,
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       97 |                         flex_array_size(new_rule, layers, num_layers));
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    Use of uninitialized value $param in regexp compilation at scripts/kernel-doc line 1532, <IN_FILE> line 146.
>    Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1484, <IN_FILE> line 146.
>    Use of uninitialized value $actual in substitution (s///) at scripts/kernel-doc line 1484, <IN_FILE> line 146.
>    Use of uninitialized value $param in substitution (s///) at scripts/kernel-doc line 1588, <IN_FILE> line 146.
>    Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1616, <IN_FILE> line 146.
>    Use of uninitialized value $param in hash element at scripts/kernel-doc line 1626, <IN_FILE> line 146.
>    Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1626, <IN_FILE> line 146.
>    Use of uninitialized value $param in hash element at scripts/kernel-doc line 1627, <IN_FILE> line 146.
>    Use of uninitialized value $param in pattern match (m//) at scripts/kernel-doc line 1629, <IN_FILE> line 146.
>    Use of uninitialized value $param in concatenation (.) or string at scripts/kernel-doc line 1630, <IN_FILE> line 146.
> >> security/landlock/ruleset.c:146: warning: Function parameter or struct member '' not described in 'insert_rule'
>    Use of uninitialized value $param in hash element at scripts/kernel-doc line 1645, <IN_FILE> line 146.
>    Use of uninitialized value $parameterlist[2] in join or string at scripts/kernel-doc line 1806, <IN_FILE> line 146.
> >> security/landlock/ruleset.c:146: warning: Excess function parameter 'layers' description in 'insert_rule'
> 
> 
> vim +/memcpy +96 security/landlock/ruleset.c
> 
>     68	
>     69	static struct landlock_rule *create_rule(
>     70			struct landlock_object *const object,
>     71			const struct landlock_layer (*const layers)[],
>     72			const u32 num_layers,
>     73			const struct landlock_layer *const new_layer)
>     74	{
>     75		struct landlock_rule *new_rule;
>     76		u32 new_num_layers;
>     77	
>     78		build_check_rule();
>     79		if (new_layer) {
>     80			/* Should already be checked by landlock_merge_ruleset(). */
>     81			if (WARN_ON_ONCE(num_layers >= LANDLOCK_MAX_NUM_LAYERS))
>     82				return ERR_PTR(-E2BIG);
>     83			new_num_layers = num_layers + 1;
>     84		} else {
>     85			new_num_layers = num_layers;
>     86		}
>     87		new_rule = kzalloc(struct_size(new_rule, layers, new_num_layers),
>     88				GFP_KERNEL_ACCOUNT);
>     89		if (!new_rule)
>     90			return ERR_PTR(-ENOMEM);
>     91		RB_CLEAR_NODE(&new_rule->node);
>     92		landlock_get_object(object);
>     93		new_rule->object = object;
>     94		new_rule->num_layers = new_num_layers;
>     95		/* Copies the original layer stack. */
>   > 96		memcpy(new_rule->layers, layers,
>     97				flex_array_size(new_rule, layers, num_layers));
>     98		if (new_layer)
>     99			/* Adds a copy of @new_layer on the layer stack. */
>    100			new_rule->layers[new_rule->num_layers - 1] = *new_layer;
>    101		return new_rule;
>    102	}
>    103	
>    104	static void free_rule(struct landlock_rule *const rule)
>    105	{
>    106		might_sleep();
>    107		if (!rule)
>    108			return;
>    109		landlock_put_object(rule->object);
>    110		kfree(rule);
>    111	}
>    112	
>    113	static void build_check_ruleset(void)
>    114	{
>    115		const struct landlock_ruleset ruleset = {
>    116			.num_rules = ~0,
>    117			.num_layers = ~0,
>    118		};
>    119	
>    120		BUILD_BUG_ON(ruleset.num_rules < LANDLOCK_MAX_NUM_RULES);
>    121		BUILD_BUG_ON(ruleset.num_layers < LANDLOCK_MAX_NUM_LAYERS);
>    122	}
>    123	
>    124	/**
>    125	 * insert_rule - Create and insert a rule in a ruleset
>    126	 *
>    127	 * @ruleset: The ruleset to be updated.
>    128	 * @object: The object to build the new rule with.  The underlying kernel
>    129	 *          object must be held by the caller.
>    130	 * @layers: One or multiple layers to be copied into the new rule.
>    131	 * @num_layers: The number of @layers entries.
>    132	 *
>    133	 * When user space requests to add a new rule to a ruleset, @layers only
>    134	 * contains one entry and this entry is not assigned to any level.  In this
>    135	 * case, the new rule will extend @ruleset, similarly to a boolean OR between
>    136	 * access rights.
>    137	 *
>    138	 * When merging a ruleset in a domain, or copying a domain, @layers will be
>    139	 * added to @ruleset as new constraints, similarly to a boolean AND between
>    140	 * access rights.
>    141	 */
>    142	static int insert_rule(struct landlock_ruleset *const ruleset,
>    143			struct landlock_object *const object,
>    144			const struct landlock_layer (*const layers)[],
>    145			size_t num_layers)
>  > 146	{
>    147		struct rb_node **walker_node;
>    148		struct rb_node *parent_node = NULL;
>    149		struct landlock_rule *new_rule;
>    150	
>    151		might_sleep();
>    152		lockdep_assert_held(&ruleset->lock);
>    153		if (WARN_ON_ONCE(!object || !layers))
>    154			return -ENOENT;
>    155		walker_node = &(ruleset->root.rb_node);
>    156		while (*walker_node) {
>    157			struct landlock_rule *const this = rb_entry(*walker_node,
>    158					struct landlock_rule, node);
>    159	
>    160			if (this->object != object) {
>    161				parent_node = *walker_node;
>    162				if (this->object < object)
>    163					walker_node = &((*walker_node)->rb_right);
>    164				else
>    165					walker_node = &((*walker_node)->rb_left);
>    166				continue;
>    167			}
>    168	
>    169			/* Only a single-level layer should match an existing rule. */
>    170			if (WARN_ON_ONCE(num_layers != 1))
>    171				return -EINVAL;
>    172	
>    173			/* If there is a matching rule, updates it. */
>    174			if ((*layers)[0].level == 0) {
>    175				/*
>    176				 * Extends access rights when the request comes from
>    177				 * landlock_add_rule(2), i.e. @ruleset is not a domain.
>    178				 */
>    179				if (WARN_ON_ONCE(this->num_layers != 1))
>    180					return -EINVAL;
>    181				if (WARN_ON_ONCE(this->layers[0].level != 0))
>    182					return -EINVAL;
>    183				this->layers[0].access |= (*layers)[0].access;
>    184				return 0;
>    185			}
>    186	
>    187			if (WARN_ON_ONCE(this->layers[0].level == 0))
>    188				return -EINVAL;
>    189	
>    190			/*
>    191			 * Intersects access rights when it is a merge between a
>    192			 * ruleset and a domain.
>    193			 */
>    194			new_rule = create_rule(object, &this->layers, this->num_layers,
>    195					&(*layers)[0]);
>    196			if (IS_ERR(new_rule))
>    197				return PTR_ERR(new_rule);
>    198			rb_replace_node(&this->node, &new_rule->node, &ruleset->root);
>    199			free_rule(this);
>    200			return 0;
>    201		}
>    202	
>    203		/* There is no match for @object. */
>    204		build_check_ruleset();
>    205		if (ruleset->num_rules >= LANDLOCK_MAX_NUM_RULES)
>    206			return -E2BIG;
>    207		new_rule = create_rule(object, layers, num_layers, NULL);
>    208		if (IS_ERR(new_rule))
>    209			return PTR_ERR(new_rule);
>    210		rb_link_node(&new_rule->node, parent_node, walker_node);
>    211		rb_insert_color(&new_rule->node, &ruleset->root);
>    212		ruleset->num_rules++;
>    213		return 0;
>    214	}
>    215	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
